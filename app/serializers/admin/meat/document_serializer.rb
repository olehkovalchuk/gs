module Admin

    module Meat
      module DocumentSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active_for_offer, :active_for_po, :need_sign, :need_before_sign, :template, :market
          translated :title

          def market
            object.markets.inject({}){|hash, i| hash.merge!(i => true)}
          end
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title
          attribute :active_for_offer, type: :state
          attribute :active_for_po, type: :state
          attribute :need_sign, type: :state
        end
      end
    end

end
