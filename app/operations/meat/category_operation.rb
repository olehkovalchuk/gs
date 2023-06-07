
module Meat
  module CategoryOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Category
      end
    end

    class FindBySeo < Base
      def perform
        @model = ::Meat::Category.find_by(seo_name: form.seo)
        add_error!(:not_fount, 'Category not found') unless model
        model
      end
    end
  end
end

