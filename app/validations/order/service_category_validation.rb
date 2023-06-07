
module Order
  module ServiceCategoryValidation
    class Base 
      include Validation::Base
      crudify do 
        attribute :active, Boolean, default: false

        multilang_attribute :title
        validate :title_multilang_presence
      end
    end
  end
end

