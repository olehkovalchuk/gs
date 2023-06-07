
module Chat
  module ContactOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Contact
      end
    end
  end
end

