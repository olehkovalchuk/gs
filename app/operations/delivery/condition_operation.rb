
module Delivery
  module ConditionOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Condition
      end
    end
  end
end

