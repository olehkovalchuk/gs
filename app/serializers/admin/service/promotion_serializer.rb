module Admin 
  
    module Service
      module PromotionSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
        end
      end
    end
  
end

