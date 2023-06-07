
module Chat
  module NotificationAction
    extend self

    # Available callbacks methods
    # after_save
    # before_save
    # after_create
    # before_create
    # after_destroy
    # before_destroy
    # after_update
    # before_update

    def after_create( model, form)
      self.send_notification( model.comment, model.recipient_company_id, model.id )
      model.recipient.increment!(:new_notifications_count)
      ::Meat::CompanyUserOperation::UpdateNotifications.( id: model.recipient.id )
    end

    def send_notification( text, user_id = nil, id = nil )
      queue =  "notifications:#{user_id ? user_id : RequestStore[:uniq_token]  }"
      ActionCable.server.broadcast queue, { text: text, id: id }
    end
  end
end



