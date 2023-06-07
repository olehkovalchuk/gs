module Admin

    module Chat
      module NotificationSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :sender_title, :sender_company_title, :recipient_title, :recipient_company_title, :comment, :action, :created_at


         def created_at
            object.created_at.strftime( "%d %b %Y %H:%M")
          end

        end
      end
    end

end
