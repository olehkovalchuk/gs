
module Order
  module ServiceCategoryOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name ServiceCategory
      end
    end
    class Up < Read 
      validate_with Order::ServiceCategoryValidation::Read
      def perform
        @model.up!
      end
    end

    class Down < Read 
      validate_with Order::ServiceCategoryValidation::Read
      def perform
        @model.down!
      end
    end
  end
end

