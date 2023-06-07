module Meat
  class Offer  < ApplicationRecord
    has_many_attached :images
    has_many :bids, as: :bidable, dependent: :delete_all
    has_many :inquiries, as: :inquirieable, dependent: :delete_all
    has_many :proceses, as: :processable, dependent: :delete_all, class_name: "::Order::Proces"
    has_many :notifications, as: :notificable, class_name: "::Chat::Notification", dependent: :delete_all
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id
    belongs_to :company_user, class_name: "::Meat::CompanyUser", foreign_key: :company_user_id
    belongs_to :category, class_name: "::Meat::Category", foreign_key: :category_id
    belongs_to :origin_country, class_name: "::Geo::Country", foreign_key: :origin, primary_key: :code

    belongs_to :port, class_name: "::Geo::Port", foreign_key: :delivery_port, primary_key: :code, optional:true

    delegate :title, to: :category, prefix: true
    delegate :title, to: :company, prefix: true
    delegate :title, to: :company_user, prefix: true
    delegate :title, to: :origin_country, prefix: true
    delegate :title, to: :port, prefix: true

    scope :active, ->(){where(active: true)}
    default_scope ->(){where(deleted: false)}
  end
end

