
module Meat
  module InvoiceValidation
    class Base
      include Validation::Base
      crudify except: [:update] do
        attribute :comment, String
        attribute :company_id, Integer
        attribute :company_user_id, Integer
        attribute :status, String, default: :created
        attribute :file, ActionDispatch::Http::UploadedFile
        validates :comment,:file, :company_id, :company_user_id, presence: true
      end
    end

    class Update
      include Validation::Base
      attribute :status, String, default: "rejected"
      attribute :id, Integer
      validates :status, :id, presence: true
    end

    class FrontList
      include Validation::Base
      attribute :page, Integer, default: 1
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      validates :page, presence: true

    end

    class Item
      include Validation::Base
      attribute :id, Integer
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      validates :id, presence: true
    end
  end
end

