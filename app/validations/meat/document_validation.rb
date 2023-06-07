
module Meat
  module DocumentValidation
    class Base
      include Validation::Base
      crudify do
        multilang_attribute :title
        attribute :active, Boolean, default: false
        attribute :template, String
        attribute :active_for_offer, Boolean, default: false
        attribute :active_for_po, Boolean, default: false
        attribute :need_sign, Boolean, default: false
        attribute :need_before_sign, Boolean, default: false
        validate :title_multilang_presence
        attribute :markets, Array[String]
        validates :markets, presence: true
      end
    end
  end
end

