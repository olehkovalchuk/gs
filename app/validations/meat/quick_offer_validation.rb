module Meat
  module QuickOfferValidation
    class Base 
      include Validation::Base
      crudify do 
        attribute :email, String
        attribute :price, Float
        attribute :country_code, String
        attribute :category_id, Integer
        attribute :user_id, Integer
        attribute :company_id, Integer
        attribute :ip, String
        attribute :referer, String
        attribute :user_agent, String
        attribute :user_country, String
        attribute :current_user, Meat::CompanyUserPresenter
        attribute :images, Array

        validates :email, :price, :country_code, :category_id, presence: true
      end
    end
  end
end
