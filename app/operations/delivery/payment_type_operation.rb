
module Delivery
  module PaymentTypeOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name PaymentType
      end
    end
  end
end

