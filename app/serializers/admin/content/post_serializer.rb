module Admin 
  
    module Content
      module PostSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :seo_name, :active
          translated :title, :text,:meta_title,:meta_description, :anons
          as_image :image 
          def image
            image_path(object.image, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
          end
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          as_image :image 
          attributes :title, :seo_name 
          attribute :active, type: :state

          def image
            image_path(object.image, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
          end


        end
      end
    end
  
end

