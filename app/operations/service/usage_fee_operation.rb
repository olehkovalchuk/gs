
module Service
  module UsageFeeOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name UsageFee
      end
    end
  end
end

