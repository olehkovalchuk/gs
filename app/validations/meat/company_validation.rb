module Meat
  module CompanyValidation
    class Base
      include Validation::Base
      crudify except: [:create], with:[:exel] do
        attribute :country_code, String
        attribute :phone, String
        attribute :phone_number, String
        attribute :title, String
        attribute :iban, String
        attribute :swift, String
        attribute :account_number, String
        attribute :tic, String
        attribute :vat, String
        attribute :eori, String
        attribute :logo, Hash
        attribute :active, Boolean, default: true
        attribute :blocked, Boolean, default: false
        attribute :moderated, Boolean, default: false
        attribute :pasport_verified, Boolean, default: false
        attribute :bill_verified, Boolean, default: false
        attribute :on_map, Boolean, default: false
        attribute :blocked_until, String
        attribute :rating_code, String
        attribute :package_expiration, String
        attribute :bank_country, String


        attribute :role, String
        attribute :about, String
        attribute :address, String
        attribute :total_emploees, Integer
        attribute :year_establishment, Integer
        attribute :plant_number, String
        attribute :representative, String

        attribute :zip, String
        attribute :zip_address, String
        attribute :bank, String
        attribute :city, String

        attribute :latitude, Float
        attribute :longitude, Float

        attribute :certificates, Array[Integer]

        attribute :logo

        attribute :offers_count_limit, Integer, default: 0
        attribute :requests_count_limit, Integer, default: 0
        attribute :received_inquries_limit, Integer, default: 0
        attribute :replyies_to_inquries_limit, Integer, default: 0
        attribute :active_chats_limit, Integer, default: 0
        attribute :show_infos_limit, Integer, default: 0
        attribute :buyer_allerts_limit, Integer, default: 0
        attribute :sub_accounts_limit, Integer, default: 0
        attribute :sended_inquries_limit, Integer, default: 0
        attribute :top_offers_limit, Integer, default: 0
        attribute :offers_count_used, Integer, default: 0
        attribute :requests_count_used, Integer, default: 0
        attribute :received_inquries_used, Integer, default: 0
        attribute :replyies_to_inquries_used, Integer, default: 0
        attribute :active_chats_used, Integer, default: 0
        attribute :show_infos_used, Integer, default: 0
        attribute :buyer_allerts_used, Integer, default: 0
        attribute :sub_accounts_used, Integer, default: 0
        attribute :sended_inquries_used, Integer, default: 0
        attribute :top_offers_used, Integer, default: 0


        validates :title, :role, :phone, presence: true
        validates :role, inclusion: {in:["seller","buyer","trader"]}
        validates :country_code, length: { is: 2 }
        validates :blocked_until, presence: true, if: ->(s){ s.blocked.presence }

        before_validation do |params|
          params.blocked_until = nil unless params.blocked.presence
          params.attributes.each_pair do |key,val|
            params.send("#{key}=",nil) if 'null' == val
          end
        end


      end
    end

    class FrontList
      include Validation::Base
      attribute :filters, Meat::FilterValidation::Base
      attribute :sorting, Meat::SortingValidation::Base
      attribute :market
    end

    class Create
      include Validation::Base
      attribute :country_code, String
      attribute :phone, String
      attribute :phone_number, String
      attribute :title, String
      attribute :seo_name, String
      attribute :rating_code, String
      attribute :role, String
      attribute :moderated, Boolean, default: false

      validates :role, inclusion: {in:["seller","buyer","trader"]}
      validates :title, :phone, :seo_name,  presence: true
      validates :country_code, length: { is: 2 }
    end

    class AddMember
      include Validation::Base
      attribute :email, String
      attribute :phone, String
      attribute :id, Integer
      attribute :password, String
      attribute :first_name, String
      attribute :last_name, String
      attribute :title, String
      attribute :country_code, String
      attribute :phone_number, String
      attribute :avatar, String
      attribute :reset_password_token, String
      attribute :is_company_owner, Boolean, default: false
      attribute :without_mailer, Boolean, default: false
      attribute :skip_limit, Boolean, default: false

      validates :email, :phone, :country_code, :phone_number, :id, :first_name, presence: true

    end

    class Item
      include Validation::Base
      attribute :page, Integer, default: 1
      attribute :id, Integer

      validates :id, presence: true

      before_validation do |params|
        params.page = 1 if params.page.to_i < 1
      end

    end

    class Members
      include Validation::Base
      attribute :with_fake, Boolean, default: false
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
    end

    class ProductList
      include Validation::Base
      attribute :id, Integer
      validates :id, presence: true
      attribute :current_user, Meat::CompanyUserPresenter
    end

    class Chart
      include Validation::Base
      attribute :current_user, Meat::CompanyUser
      attribute :period, String, default: 'all'
      attribute :chart, String, default: 'in'
      validates :current_user, :period, :chart , presence: true

    end

    class AddDocuments
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      attribute :passport, ActionDispatch::Http::UploadedFile
      attribute :bill, ActionDispatch::Http::UploadedFile

      validates :passport, presence: true, unless: ->(o){ o.bill.present? }
      validates :bill, presence: true, unless: ->(o){ o.passport.present? }
    end

    class DeleteDocument < Read
      attribute :document, String
      validates :document, presence: true
    end

  end
end

