module Admin

    module Order
      module ServiceSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :usage_type, :usage_period, :active, :code, :price, :old_price, :currency
          translated :title
          translated :usage_title
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title, :usage_title, :price, :currency
          attribute :active, type: :state
        end
      end
    end

end
