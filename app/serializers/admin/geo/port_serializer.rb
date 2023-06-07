module Admin 
  
    module Geo
      module PortSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :code, :region_code, :country_code ,:latitude, :longitude, :active
          translated :title
        end
        class List < BeOneAdmin::Serializer
          self.sorting ={
            title: :title,
            country_title: :country_code,
            region_title: :region_code,
            code: :code
          }


          attribute :id, type: :hidden
          attributes :title, :code, :region_title, :country_title
          attribute :active, type: :state
        end
      end
    end
  
end

