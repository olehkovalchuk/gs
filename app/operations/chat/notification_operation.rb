
module Chat
  module NotificationOperation
    class Base
      include Operation::Base
      crudify except: [:read] do
        model_name Notification
      end
    end

    class CabinetList < Base
      LIMIT = 15
      def perform
        conditions = form.current_user.is_company_owner ? {recipient_company_id: form.current_user.company_id } : {recipient_company_user_id: form.current_user.id }
        @model = Chat::Notification.page(form.page).per(LIMIT).order(updated_at: :desc).where(conditions)
        form.current_user.company.notifications.update_all(read: true)
        form.current_user.update(notifications_viewed_date: Time.zone.now, new_notifications_count: 0)
        @model.total_pages
      end
    end

    class Read < Base
      def perform
        @model = form.current_user.company.notifications.find_by(id: form.id)
        @model.update(read: true) if model
        true
      end
    end

    class Send < Base
      def perform
        form.current_user.company.notifications.where(read: false).each do |item|
          ::Chat::NotificationAction.send_notification(item.comment, form.current_user.company_id, item.id)
        end
      end
    end
  end
end
