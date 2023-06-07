
module Meat
  module DocumentOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Document
      end
    end
  end
end

