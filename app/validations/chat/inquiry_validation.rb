
module Chat
  module InquiryValidation
    class Base 
      include Validation::Base
      crudify except: [:update] do 
        attribute :title, String
        attribute :sender_email, String
        attribute :receiver_email, String
        attribute :message, String
        attribute :inquirieable_type, String
        attribute :inquirieable_id, Integer
        attribute :sender_company_id, Integer
        attribute :sender_company_user_id, Integer
        attribute :recipient_company_id, Integer
        attribute :recipient_company_user_id, Integer
        attribute :with_recount, Boolean, default: true
      
        attribute :current_user, Meat::CompanyUserPresenter
        attribute :phone, String
        attribute :phone_number, String
        attribute :country_code, String
        attribute :post_request, Boolean, default: false


        validates :title, :sender_email, :receiver_email, :message, :inquirieable_type, :inquirieable_id, :recipient_company_id, :recipient_company_user_id,  presence: true
        validates :phone, :phone_number, :country_code,  presence: true

      end
    end

    class Send < Read
    end

    class Update < Read
      attribute :message, String
      validates :message, presence: true
    end

    class Replay
      include Validation::Base
      attribute :message, String
      attribute :id, String
      validates :message, presence: true
    end

  end
end

