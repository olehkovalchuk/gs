
module Delivery
  module PaymentTypeValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        attribute :active, Boolean, default: false 
        attribute :has_prepay, Boolean, default: false 
        validate :title_multilang_presence
      end
    end
  end
end

