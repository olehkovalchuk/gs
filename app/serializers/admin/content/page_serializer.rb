module Admin 
  
    module Content
      module PageSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :seo_name
          translated :title, :text,:meta_title,:meta_description
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title, :seo_name
        end
      end
    end
  
end

