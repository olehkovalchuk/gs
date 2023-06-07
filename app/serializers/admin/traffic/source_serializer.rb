module Admin 
  
    module Traffic
      module SourceSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :name
        end
        class List < BeOneAdmin::Serializer
          attributes :id, :name
        end
      end
    end
  
end

