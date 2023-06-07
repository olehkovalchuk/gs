module Admin 
  
    module Delivery
      module PaymentTypeSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active, :has_prepay
          translated :title
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title
          attribute :active, type: :state
        end
      end
    end
  
end

