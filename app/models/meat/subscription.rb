
module Meat
  class Subscription  < ApplicationRecord
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id
    belongs_to :company_user, class_name: "::Meat::CompanyUser", foreign_key: :company_user_id
    delegate :title, to: :company, prefix: true
    delegate :title, to: :company_user, prefix: true
  end
end



