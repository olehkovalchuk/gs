
module Order
  module StepOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Step
      end
    end
  end
end

