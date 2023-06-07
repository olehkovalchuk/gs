module Meat
  class Alert < ApplicationRecord
    belongs_to :category, class_name: "::Meat::Category", foreign_key: :category_id
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id

    delegate :title, to: :category, prefix: true
    delegate :title, to: :company, prefix: true

  end
end

