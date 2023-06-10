# == Schema Information
#
# Table name: meat_bids
#
#  id                        :bigint           not null, primary key
#  currency                  :string           not null
#  amount                    :float            not null
#  comment                   :string
#  bidable_type              :string           not null
#  bidable_id                :integer          not null
#  sender_company_id         :integer          not null
#  sender_company_user_id    :integer          not null
#  recipient_company_id      :integer          not null
#  recipient_company_user_id :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  active                    :boolean          default(TRUE)
#
module Meat
  class Bid  < ApplicationRecord
    belongs_to :sender, class_name: "::Meat::CompanyUser", foreign_key: :sender_company_user_id
    belongs_to :sender_company, class_name: "::Meat::Company", foreign_key: :sender_company_id
    belongs_to :recipient, class_name: "::Meat::CompanyUser", foreign_key: :recipient_company_user_id
    belongs_to :recipient_company, class_name: "::Meat::Company", foreign_key: :recipient_company_id

    delegate :title, to: :sender, prefix: true
    delegate :title, to: :sender_company, prefix: true
    delegate :title, to: :recipient, prefix: true
    delegate :title, to: :recipient_company, prefix: true

    scope :active, ->(){where(active: true)}

    belongs_to :bidable, polymorphic: true

  end
end

