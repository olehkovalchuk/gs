# == Schema Information
#
# Table name: meat_offers
#
#  id                  :bigint           not null, primary key
#  category_id         :integer          not null
#  company_id          :integer          not null
#  company_user_id     :integer          not null
#  delivery_conditions :string           default([]), is an Array
#  payment_types       :string           default([]), is an Array
#  certificates        :integer          default([]), is an Array
#  documents           :integer          default([]), is an Array
#  packages            :integer          default([]), is an Array
#  permissions_to      :jsonb            not null
#  package_type        :string           default("fixed"), not null
#  weight_from         :float
#  weight_to           :float
#  weight_type         :string(2)
#  length_from         :float
#  length_to           :float
#  length_type         :string(2)
#  description         :text
#  plant_number        :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  origin              :string(2)        not null
#  plain_permissions   :jsonb            not null
#  delivery_type       :string
#  delivery_port       :string
#  delivery_country    :string
#  currency            :string
#  price_type          :string           default("MT")
#  quantity            :float            not null
#  quantity_type       :string           default("T"), not null
#  week_from           :integer
#  week_to             :integer
#  active              :boolean          default(FALSE)
#  deleted             :boolean          default(FALSE)
#  price_from          :float            default(0.0), not null
#  price_to            :float            default(0.0), not null
#  in_top              :boolean          default(FALSE)
#  in_top_expire_at    :date
#  market              :string           default("meat"), not null
#
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

