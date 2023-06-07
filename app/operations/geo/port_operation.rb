
module Geo
  module PortOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Port
      end
    end
  end
end

