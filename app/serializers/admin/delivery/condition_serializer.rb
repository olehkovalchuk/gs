module Admin

    module Delivery
      module ConditionSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active, :code, :need_seller_country, :need_seller_port, :need_buyer_port, :need_buyer_country, :need_sea_line, :safe_deal
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes  :code
          attribute :active, type: :state
        end
      end
    end

end
