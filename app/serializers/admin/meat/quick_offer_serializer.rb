module Admin 
  
    module Meat
      module QuickOfferSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :logo
          def logo
            image_path(object.images.first, ActionController::Base.helpers.image_url("product-s.png"), '400x300')
          end
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          as_image :logo
          attributes :email, :price, :country_title, :category_title, :user_email, :company_title
          def logo
            image_path(object.images.first, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
          end
        end
      end
    end
  
end
