
module Chat
  module FeedbackOperation
    class Base
      include Operation::Base
      crudify except: [:create] do
        model_name Feedback
      end
    end

    class Create < Base
      def perform
        default_company = ::Meat::Company.find(::Setting.get("admin_company_id"))
        default_user = default_company.managers.first
        @model = Chat::Feedback.create!(
          deleted: false,
          text: form.text,
          sender_company_id: form.current_user.company_id,
          sender_company_user_id: form.current_user.id,
          recipient_company_id: default_company.id,
          recipient_company_user_id: default_user.id,
        )
      end
    end
  end
end

