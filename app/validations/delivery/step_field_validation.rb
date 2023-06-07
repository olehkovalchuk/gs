
module Delivery
  module StepFieldValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        attribute :field_type, String
        validates :field_type, presence: true
        validate :title_multilang_presence
      end
    end
  end
end

