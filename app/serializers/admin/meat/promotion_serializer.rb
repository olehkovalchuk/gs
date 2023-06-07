module Admin 
  
    module Meat
      module PromotionSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :promo_type, :product, :company_title


          def product
            return "<b>DELETED</b>" unless object.promotable
            "<a href='/marketplace/#{object.promotable_type.demodulize.downcase}s/#{object.promotable_id}' target='_blank'>#{object.promotable.category_title}</a>"
          end

        end
      end
    end
  
end

