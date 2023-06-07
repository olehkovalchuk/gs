
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



