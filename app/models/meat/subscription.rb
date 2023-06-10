# == Schema Information
#
# Table name: meat_subscriptions
#
#  id              :bigint           not null, primary key
#  company_id      :integer          not null
#  company_user_id :integer          not null
#  category_ids    :integer          default([]), not null, is an Array
#  type            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
module Meat
  class Subscription  < ApplicationRecord
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id
    belongs_to :company_user, class_name: "::Meat::CompanyUser", foreign_key: :company_user_id
    delegate :title, to: :company, prefix: true
    delegate :title, to: :company_user, prefix: true
  end
end



