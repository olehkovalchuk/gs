module Admin
    module Chat
      module MessageSerializer
        class Item < BeOneAdmin::Serializer
          attributes :text, :id, :status
        end

        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden

          attributes :sender_company_title, :sender_title,:recipient_company_title, :recipient_title, :created_at
          attributes :text

          attribute :status, type: :enum

          attribute :status_text, type: :hidden

          def status_text
            object.status
          end

          def created_at
            format = if object.updated_at < Date.today.beginning_of_day
              "%d %b %Y"
            else
              "%H:%M"
            end
            object.updated_at.strftime(format)
          end
        end

        class Relation < List
        end
      end
    end
end
