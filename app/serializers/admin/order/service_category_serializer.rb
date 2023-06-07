module Admin 
  
    module Order
      module ServiceCategorySerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active
          translated :title

        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title
          with_type :state, :active
        end
      end
    end
  
end

