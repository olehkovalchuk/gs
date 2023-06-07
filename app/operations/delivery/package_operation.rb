
module Delivery
  module PackageOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Package
      end
    end
  end
end

