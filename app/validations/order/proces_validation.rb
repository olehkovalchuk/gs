
module Order
  module ProcesValidation

    class CopySteps
      include Validation::Base
      attribute :item, Order::Proces
      validates :item, presence: true
    end

    class GenerateDocs < CopySteps
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
    end



    class FrontList
      include Validation::Base
      attribute :page, String, default: 1
      attribute :filter, String, default: 'all'
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      validates :page, :filter, presence: true
    end

    class ContactPerson
      include Validation::Base
      attribute :phone_number, String
      attribute :phone, String
      attribute :country_code, String
      attribute :first_name, String
      attribute :last_name, String
      attribute :email, String
      attribute :title, String
    end

    class Company
      include Validation::Base
      attribute :title, String
      attribute :address, String
      attribute :phone_number, String
      attribute :phone, String
      attribute :country_code, String
      attribute :zip_address, String
      attribute :account_number, String
      validates :title,:address, :phone, :phone_number, :country_code,  presence: true
    end


    class Base
      include Validation::Base
      crudify except: [:create, :update] do

      end
    end

    class ReadWithAuth < Base
      attribute :id, String
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, :id, presence: true
    end

    class Upload < ReadWithAuth
      attribute :files, Hash
      validates :files, presence: true
    end

    class CompleteStep < ReadWithAuth
      attribute :step, Integer
      attribute :fields, Hash
    end

    class ShowStep < ReadWithAuth
      attribute :step, Integer
    end

    class Download < ReadWithAuth
      attribute :doc_id, Integer
      validates :doc_id, presence: true
    end


    class Create
      include Validation::Base
      attribute :origin, String
      attribute :title, String
      attribute :quantity, Integer
      attribute :price, Integer
      attribute :packing, Integer
      attribute :currency, String
      attribute :delivery_code, String
      attribute :comment, String
      attribute :shiping_line, String
      attribute :draft, Boolean, default: false
      attribute :is_safe, Boolean, default: false
      attribute :destination_port, String
      attribute :documents, Array[Integer]
      attribute :files, Hash

      attribute :additional_contact_person, ContactPerson

      attribute :company, Company
      attribute :product_id, Integer
      attribute :payment_type_id, Integer
      attribute :month_of_production, Integer
      attribute :pre_pay, Float
      attribute :post_pay, Float

      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true

      validates :title, :payment_type_id, presence: true
      validates :quantity, presence: true, numericality: {greater_than: 0 }
      validates :price, presence: true, numericality: {greater_than: 0 }
      validates :origin, presence: true, length: {is:2}
      validates :currency, presence: true, length: {is:3}
      validates :delivery_code, presence: true, length: {is:3}


      before_validation do |params|
        params.is_safe = params.is_safe.presence || false
        if params.additional_contact_person
          params.additional_contact_person = ContactPerson.new(params.additional_contact_person)
          errors.add(:additional_contact_person, 'Contact person is not valid') unless params.additional_contact_person.valid?
        end
        params.company = Company.new(params.company)
        errors.add(:company, 'Company person is not valid') unless params.company.valid?
      end

    end

    class Update < Create
      attribute :approved_for_safe, Boolean, default: false
    end
  end
end

