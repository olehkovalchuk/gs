module Admin 
  
    module Order
      module ServiceItemSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :service_category_id, :active
          translated :title

        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title, :service_category_title
          with_type :state, :active
        end
        class Relation < BeOneAdmin::Serializer 
          attribute :id, type: :hidden
          attributes :title
          with_type :state, :active

        end
      end
    end
  
end

