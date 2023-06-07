
module Order
  module ItemOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Item
      end
    end
  end
end

