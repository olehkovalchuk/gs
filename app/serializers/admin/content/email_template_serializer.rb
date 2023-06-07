module Admin 
  
    module Content
      module EmailTemplateSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :code
          translated :title, :text
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title, :code
        end
      end
    end
  
end

