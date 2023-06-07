
module Traffic
  module SourceOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Source
      end
    end
  end
end

