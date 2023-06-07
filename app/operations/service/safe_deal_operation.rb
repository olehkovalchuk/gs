
module Service
  module SafeDealOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name SafeDeal
      end
    end
  end
end

