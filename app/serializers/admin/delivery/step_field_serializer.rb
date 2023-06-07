module Admin

    module Delivery
      module StepFieldSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :field_type
          translated :title
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title, :field_type
        end
        class Relation  < List

        end
      end
    end

end
