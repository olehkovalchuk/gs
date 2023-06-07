module Admin

    module Chat
      module ContactSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :text
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :name, :email, :text, :created_at

          def text
            object.text.first(20)
          end

          def created_at
            object.created_at.strftime( "%d %b %Y %H:%M")
          end

        end
      end
    end

end
