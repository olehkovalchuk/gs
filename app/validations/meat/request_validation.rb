
module Meat
  module RequestValidation
    class Base
      include Validation::Base
      crudify do
        attribute :company_id, Integer
        attribute :company_user_id, Integer

        attribute :active, Boolean, default: true
        attribute :category_id, Integer
        attribute :quantity, Integer, default: 0

        attribute :certificates, Array[Integer], default: []
        attribute :delivery_conditions, Array[String], default: []
        attribute :documents, Array[Integer], default: []
        attribute :payment_types, Array[Integer], default: []
        attribute :permissions_to, Array[String], default: []
        attribute :origins, Array[String], default: []

        attribute :subscribe, Boolean, default: false

        attribute :currency, String

        attribute :price_from, Float, defualt: 1
        attribute :price_to, Float, defualt: 1
        attribute :market, String

        attribute :description, String
        attribute :market_param, String

        validates :category_id, :market, :company_user_id, :company_id,  presence: true

        validates :currency, length: {is: 3}, allow_nil: true, allow_blank: true



        validates_numericality_of :price_from, greater_than_or_equal_to: 0, allow_nil: true, allow_blank: true
        validates_numericality_of :price_to, greater_than_or_equal_to: 0, allow_nil: true, allow_blank: true


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

    class ReadWithAuth < Read
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :kibana_log, String
    end

    class CreateFromOffer < Read
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
    end

    class DestroyWithAuth < ReadWithAuth
    end

    class Send < Read
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      attribute :id, Integer
      attribute :comment, String
      attribute :ids, Array[Integer]
      validates :id, :ids, :comment,  presence: true

    end

    class Renew < Add
      attribute :id, Integer
      validates :id,  presence: true
    end

    class FrontList
      include Validation::Base

      attribute :company_id, Integer, default: 0
      attribute :filters, Meat::FilterValidation::Base
      attribute :sorting, Meat::SortingValidation::Base
      attribute :page, Integer, default: 1
      attribute :by_company, Boolean, default: false
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :market, String

      validates :page, :market, presence: true
      validates :filters, presence: true, if: ->(o){ o.company_id.zero? }
      validates_numericality_of :page, greater_than_or_equal_to: 1
      before_validation do |form|
        errors.add(:filters,:invalid) if form.filters && !form.filters.valid?
      end

    end

  end
end

