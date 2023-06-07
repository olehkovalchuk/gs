
module Order
  module PaymentTransactionValidation
    class Base
      include Validation::Base
      crudify except: [:update] do
        attribute :status, String
        attribute :description, String
        attribute :amount, Float
        attribute :currency, String
        attribute :item_type, String
        attribute :company_id, Integer
        attribute :company_user_id, Integer
        attribute :item_id, Integer
        attribute :system, String
        attribute :system_id, String
        attribute :token, String

        validates :token, :system, :item_id, :company_user_id, :company_id, :item_type, :currency, :amount, :description, :status,  presence: true
      end
    end

    class Update < Read
      attribute :system_id, String
      attribute :status, String
      validates :system_id, :status,  presence: true
    end

    class Success < Read
      attribute :token, String
      attribute :security, String
      attribute :paymentId, String
      attribute :PayerID, String
      validates :token, :security, :paymentId, :PayerID ,  presence: true
    end

    class ForceCreate
      include Validation::Base
      attribute :company_id, Integer
      attribute :item_id, Integer
      attribute :current_user
      validates :item_id, :company_id, :current_user,  presence: true
    end


    class Cancelled < Read

    end

    class FrontList
      include Validation::Base
      attribute :page, String, default: 1
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      validates :page, presence: true
    end

  end
end
