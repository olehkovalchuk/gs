
module Content
  module FaqOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Faq
      end
    end

    class FrontList < Base

      def perform 
        Content::Faq.select('id, title, category').active.inject({}) do |hash, item|
          hash[item.category] ||= []
          hash[item.category] << {id: item.id, title: item.title, category: item.category}
          hash
        end
      end
      
    end
  end
end

