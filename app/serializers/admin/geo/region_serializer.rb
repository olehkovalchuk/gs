module Admin 
  
    module Geo
      module RegionSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :code
          translated :title
        end
        class List < BeOneAdmin::Serializer
          self.sorting ={
            title: :title,
            code: :code
          }
          attribute :id, type: :hidden
          attributes :title, :code
        end
      end
    end
  
end

