# == Schema Information
#
# Table name: meat_requests
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(FALSE)
#  certificates        :integer          default([]), not null, is an Array
#  currency            :string
#  deleted             :boolean          default(FALSE)
#  delivery_conditions :string           default([]), is an Array
#  delivery_country    :string
#  delivery_port       :string
#  delivery_type       :string
#  description         :text
#  documents           :integer          default([]), not null, is an Array
#  in_top              :boolean          default(FALSE)
#  in_top_expire_at    :date
#  market              :string           default("meat"), not null
#  origin              :string(2)
#  origins             :string           default([]), not null, is an Array
#  payment_types       :string           default([]), is an Array
#  permissions_to      :jsonb            not null
#  plain_permissions   :jsonb            not null
#  price_from          :float            default(0.0), not null
#  price_to            :float            default(0.0), not null
#  price_type          :string           default("MT")
#  quantity            :float            not null
#  quantity_type       :string           default("T"), not null
#  subscribe           :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  category_id         :integer          not null
#  company_id          :integer          not null
#  company_user_id     :integer          not null
#
module Meat
  class Request  < ApplicationRecord
    has_many :bids, as: :bidable, dependent: :delete_all
    has_many :inquiries, as: :inquirieable, dependent: :delete_all
    has_many :notifications, as: :notificable, class_name: "::Chat::Notification", dependent: :delete_all
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id
    belongs_to :company_user, class_name: "::Meat::CompanyUser", foreign_key: :company_user_id
    belongs_to :category, class_name: "::Meat::Category", foreign_key: :category_id
    delegate :title, to: :category, prefix: true
    delegate :title, to: :company, prefix: true

    scope :active, ->(){where(active: true)}
    default_scope ->(){where(deleted: false)}
  end
end



