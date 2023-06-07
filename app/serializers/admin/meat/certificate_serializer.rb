module Admin 
  
    module Meat
      module CertificateSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active, :market
          translated :title
          as_image :logo

          def market
            object.markets.inject({}){|hash, i| hash.merge!(i => true)}
          end
          def logo
            image_path(object.logo)
          end
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          as_image :logo
          attributes :title
          attribute :active, type: :state

          def logo
            image_path(object.logo)
          end

        end
      end
    end
  
end

