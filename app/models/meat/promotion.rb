
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



