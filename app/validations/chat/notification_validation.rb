
module Chat
  module NotificationValidation
    class Base
      include Validation::Base
      crudify except: [:read] do
        attribute :action, String
        attribute :params, Hash
        attribute :comment, String
        attribute :notificable_type, String
        attribute :item_type, String, default: "offers"
        attribute :notificable_id, Integer
        attribute :sender_company_id, Integer
        attribute :sender_company_user_id, Integer
        attribute :recipient_company_id, Integer
        attribute :recipient_company_user_id, Integer



        validates :action, :params, :comment, :notificable_type, :notificable_id, :sender_company_id, :sender_company_user_id, :recipient_company_id, :recipient_company_user_id,  presence: true

      end
    end
    class CabinetList
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      attribute :page, Integer, default: 1
      validates :page, presence: true
    end

    class Read
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      attribute :id, Integer
      validates :id, presence: true
    end

    class Send
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
    end
  end
end
