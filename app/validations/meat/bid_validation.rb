
module Meat
  module BidValidation
    class Base
      include Validation::Base
      crudify do
        attribute :currency, String
        attribute :amount, Integer
        attribute :comment, String
        attribute :bidable_type, String
        attribute :bidable_id, Integer
        attribute :sender_company_id, Integer
        attribute :sender_company_user_id, Integer
        attribute :recipient_company_id, Integer
        attribute :recipient_company_user_id, Integer
      
        attribute :current_user, Meat::CompanyUserPresenter
        validates :current_user, presence: true


        validates :current_user, :currency, :amount, :comment, :bidable_type, :bidable_id, :sender_company_id, :sender_company_user_id, :recipient_company_id, :recipient_company_user_id,  presence: true

      end
    end

    class DestroyWithAuth < Read
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :kibana_log, String
    end

    class FrontList
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      attribute :page, Integer, default: 1      
      validates :page, presence: true
    end
  end
end
