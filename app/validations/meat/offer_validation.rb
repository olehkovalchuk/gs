
module Meat
  module OfferValidation
    class Base
      include Validation::Base
      crudify  do

        attribute :company_id, Integer
        attribute :company_user_id, Integer
        attribute :delivery_port, String
        attribute :plant_number, String
        attribute :weight_from, Float
        attribute :weight_to, Float
        attribute :quantity, Integer, default: 0
        attribute :length_from, Float
        attribute :length_to, Float
        attribute :category_id, Integer
        attribute :weight_type, String
        attribute :length_type, String
        attribute :certificates, Array[Integer], default: []
        attribute :documents, Array[Integer], default: []
        attribute :payment_types, Array[Integer], default: []
        attribute :permissions_to, Array[String], default: []
        attribute :delivery_conditions, Array[String], default: []
        attribute :packages, Array[Integer], default: []

        attribute :currency, String
        attribute :active, Boolean, default: true
        attribute :price_from, Float, default: 1
        attribute :price_to, Float, default: 1
        attribute :origin, String
        attribute :market, String
        attribute :market_param, String

        attribute :description, String
        attribute :week_from, Integer
        attribute :week_to, Integer
        attribute :images, Array[ActionDispatch::Http::UploadedFile], default: []


        validates :category_id, :market, :payment_types, :delivery_conditions, :company_user_id, :company_id,  presence: true

        validates :currency, length: {is: 3}
        validates :origin, length: {is: 2}

        validates :week_from, inclusion: { in: (1..52).to_a }, allow_nil: true, allow_blank: true
        validates :week_to, inclusion: { in: (1..52).to_a }, allow_nil: true, allow_blank: true

        validates :length_type, inclusion: { in: ["CM"] }, allow_nil: true, allow_blank: true
        validates :weight_type, inclusion: { in: ["gr","KG","LB", "T"] }, allow_nil: true, allow_blank: true



        validates_numericality_of :price_from, greater_than_or_equal_to: 1

        before_validation do |obj|
          obj.price_to = obj.price_from if obj.price_to.to_i.zero?
          obj.attributes.each_pair do |key,val|
            obj.send("#{key}=",nil) if 'null' == val
          end
          obj.market = obj.market_param if obj.market_param.present?
        end

      end
    end

    class Add < Create

      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true

      before_validation do |form|
        if form.current_user.present?
          form.company_id = form.current_user.company_id
          form.company_user_id = form.current_user.id
        end
      end
    end

    class Renew < Add
      attribute :id, Integer
      validates :id,  presence: true
    end


    class SendToPromote 
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      attribute :promo_type, String
      attribute :ids, Array[Integer]
      validates :ids, :promo_type,  presence: true
    end

    class FrontList
      include Validation::Base
      attribute :by_company, Boolean, default: false
      attribute :skip_limit, Boolean, default: false
      attribute :company_id, Integer, default: 0
      attribute :filters, Meat::FilterValidation::Base
      attribute :sorting, Meat::SortingValidation::Base
      attribute :page, Integer, default: 1
      attribute :market, String
      attribute :current_user, Meat::CompanyUserPresenter

      validates :page, :market, presence: true
      validates :filters, presence: true, if: ->(o){ o.company_id.zero? }
      validates_numericality_of :page, greater_than_or_equal_to: 1

      before_validation do |form|
        errors.add(:filters,:invalid) if form.filters && !form.filters.valid?
      end

    end

    class CabinetList
      include Validation::Base
      attribute :filters, Meat::FilterValidation::Base
      attribute :page, String, default: 1
      attribute :by_company, Boolean, default: false
      attribute :skip_limit, Boolean, default: false
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      validates :page, presence: true
      before_validation do |form|
        errors.add(:filters,:invalid) if form.filters && !form.filters.valid?
      end

    end

    class ReadWithAuth < Read
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :kibana_log, String
    end

    class DestroyWithAuth < ReadWithAuth
    end

    class RemoveAttach < ReadWithAuth
      attribute :id, Integer
      attribute :attach_id, Integer
      attribute :attach_type, String
      validates :id,:attach_id,:attach_type, presence: true
    end

    class Bid < Read
      attribute :comment, String
      attribute :currency, String
      attribute :amount, Integer
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      validates :currency, :currency, :amount, presence: true
    end


    class Inquiry < Read
      attribute :title, String
      attribute :sender_email, String
      attribute :phone, String
      attribute :phone_number, String
      attribute :country_code, String
      attribute :post_request, Boolean, default: false

      attribute :message, String
      attribute :ip, String
      attribute :referer, String
      attribute :user_agent, String
      attribute :user_country, String
      attribute :current_user, Meat::CompanyUserPresenter
      validates :title, :sender_email, :message, :phone, :phone_number, :country_code, presence: true
    end

  end
end


