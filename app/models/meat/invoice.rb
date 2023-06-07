
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



