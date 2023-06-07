module Admin

    module Order
      module ItemSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :service_id, :is_included
          translated :title
        end
        class List < BeOneAdmin::Serializer
          hidden :id, :service_id
          attributes :title
          with_type :state, :is_included
        end

        class Relation < List

        end
      end
    end

end

