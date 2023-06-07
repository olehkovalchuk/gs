
module Geo
  module SeaLineOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name SeaLine
      end
    end
  end
end

