
module Delivery
  module PackageValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        attribute :active, Boolean, default: false 
        attribute :markets, Array[String]
        validates :markets, presence: true
        validate :title_multilang_presence
      end
    end
  end
end

