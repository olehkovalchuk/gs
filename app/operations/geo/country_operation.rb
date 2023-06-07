
module Geo
  module CountryOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Country
      end
    end
  end
end

