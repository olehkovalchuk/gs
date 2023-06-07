
module Service
  module PromotionValidation
    class Base 
      include Validation::Base
      crudify do 
        # attribute :some_attr, String, default: ""
        # validates :some_attr, presence: true
      end
    end
  end
end

