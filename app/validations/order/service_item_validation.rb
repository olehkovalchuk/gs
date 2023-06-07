
module Order
  module ServiceItemValidation
    class Base 
      include Validation::Base
      crudify do 
        attribute :service_category_id, Integer
        attribute :active, Boolean, default: false
        validates :service_category_id, presence: true
        multilang_attribute :title
        validate :title_multilang_presence
        
      end
    end
  end
end

