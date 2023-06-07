
module Delivery
  module ConditionValidation
    class Base
      include Validation::Base
      crudify do
        attribute :code, String
        attribute :active, Boolean, default: false
        attribute :need_seller_port, Boolean, default: false
        attribute :need_seller_country, Boolean, default: false
        attribute :need_buyer_port, Boolean, default: false
        attribute :need_buyer_country, Boolean, default: false
        attribute :need_sea_line, Boolean, default: false
        attribute :safe_deal, Boolean, default: false
        validates :code, presence: true
      end
    end
  end
end

