
module Order
  module FileOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name File
      end
    end
  end
end

