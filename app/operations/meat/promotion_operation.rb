
module Meat
  module PromotionOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Promotion
      end
    end
  end
end

