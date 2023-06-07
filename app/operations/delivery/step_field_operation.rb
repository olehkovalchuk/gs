
module Delivery
  module StepFieldOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name StepField
      end
    end
  end
end

