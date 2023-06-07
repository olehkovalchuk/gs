module Meat
  class QuickOffer  < ApplicationRecord
    belongs_to :company, foreign_key: :company_id, class_name: '::Meat::Company'
    belongs_to :country, foreign_key: :country_code, primary_key: :code, class_name: '::Geo::Country'
    belongs_to :user, foreign_key: :user_id, class_name: '::Meat::CompanyUser'
    belongs_to :category, foreign_key: :category_id, class_name: '::Meat::Category'

    delegate :title, to: :company, prefix: true
    delegate :title, to: :country, prefix: true
    delegate :title, to: :category, prefix: true
    delegate :email, to: :user, prefix: true

    has_many_attached :images

  end
end
