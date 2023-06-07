module Admin 
  
    module Geo
      module SeaLineSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :title, :active
        end
        class List < BeOneAdmin::Serializer
          self.sorting ={ title: :title }
          attribute :id, type: :hidden
          attributes :title
          attribute :active, type: :state
        end
      end
    end
  
end

