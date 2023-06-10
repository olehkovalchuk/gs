# == Schema Information
#
# Table name: meat_alerts
#
#  id          :bigint           not null, primary key
#  category_id :integer          not null
#  company_id  :integer          not null
#
# Indexes
#
#  index_meat_alerts_on_category_id  (category_id)
#  index_meat_alerts_on_company_id   (company_id)
#
module Meat
  class Alert < ApplicationRecord
    belongs_to :category, class_name: "::Meat::Category", foreign_key: :category_id
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id

    delegate :title, to: :category, prefix: true
    delegate :title, to: :company, prefix: true

  end
end

