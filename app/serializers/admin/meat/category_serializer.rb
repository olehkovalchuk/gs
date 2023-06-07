module Admin 
  
    module Meat
      module CategorySerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :parent_id, :active, :icon, :cls, :market
          translated :title
          as_image :image 
          def image
            image_path(object.image, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
          end
        end
        class List < BeOneAdmin::Serializer
          self.sorting ={
            title: :title,
            parent_title: :parent_id,
            offers_count: :offers_count,
            requests_count: :requests_count
          }
          as_image :image 
          def image
            image_path(object.image, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
          end
          attribute :id, type: :hidden
          attributes :market, :title, :parent_title
          attribute :active, type: :state
          attributes :offers_count, :requests_count
        end
      end
    end
  
end
