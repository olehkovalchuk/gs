# == Schema Information
#
# Table name: meat_invoices
#
#  id              :bigint           not null, primary key
#  comment         :text
#  status          :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer          not null
#  company_user_id :integer          not null
#  process_id      :integer
#
# Indexes
#
#  index_meat_invoices_on_company_id       (company_id)
#  index_meat_invoices_on_company_user_id  (company_user_id)
#
module Meat
  class Invoice  < ApplicationRecord
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id
    belongs_to :company_user, class_name: "::Meat::CompanyUser", foreign_key: :company_user_id
    delegate :title, to: :company, prefix: true
    delegate :title, to: :company_user, prefix: true

    has_one_attached :file


    enum status: {
      created: "created",
      approved: "approved",
      rejected: "rejected",
    }

    # %w{new approved rejected}.each do |status|
    #   scope status, ->(){where(status: status)}
    # end

  end
end



