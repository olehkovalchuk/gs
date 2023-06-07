module Admin 
  
    module Geo
      module CountrySerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :code, :region_code
          translated :title
        end
        class List < BeOneAdmin::Serializer
          self.sorting ={
            title: :title,
            region_title: :region_code,
            code: :code
          }
          attribute :id, type: :hidden
          attributes :title, :code, :region_title
        end
      end
    end
  
end

