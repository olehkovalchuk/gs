module Admin 
  
    module Delivery
      module PackageSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active, :market
          translated :title

          def market
            object.markets.inject({}){|hash, i| hash.merge!(i => true)}
          end
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title
          attribute :active, type: :state
        end
      end
    end
  
end

