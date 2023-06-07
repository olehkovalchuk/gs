module Admin 
  
    module Delivery
      module StepSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :delivery_code, :seller_step, :buyer_step, :position
          translated :title
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title, :position
          attribute :seller_step, type: :state
          attribute :buyer_step, type: :state
        end
        class Relation < List
        end
      end
    end
  
end

