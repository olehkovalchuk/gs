# == Schema Information
#
# Table name: meat_promotions
#
#  id              :bigint           not null, primary key
#  promo_type      :string           not null
#  promotable_type :string           not null
#  promotable_id   :integer          not null
#  company_id      :integer          not null
#  company_user_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
module Meat
  class Promotion  < ApplicationRecord
    belongs_to :promotable, polymorphic: true

    enum promo_type: {
      email: "email",
      social: "social",
      complex: "complex",
    }

    belongs_to :user, class_name: "::Meat::CompanyUser", foreign_key: :company_user_id
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id


    delegate :title, to: :user, prefix: true
    delegate :title, to: :company, prefix: true

  end
end



