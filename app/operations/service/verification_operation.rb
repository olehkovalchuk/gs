
module Service
  module VerificationOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Verification
      end
    end
  end
end

