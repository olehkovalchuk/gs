
module Order
  module ServiceItemOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name ServiceItem
      end
    end
    class Up < Read 
      validate_with Order::ServiceItemValidation::Read
      def perform
        @model.up!
      end
    end

    class Down < Read 
      validate_with Order::ServiceItemValidation::Read
      def perform
        @model.down!
      end
    end
  end
end

