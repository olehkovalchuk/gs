module Admin

    module Chat
      module FeedbackSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :text
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden

          attributes :sender_title, :recipient_title, :rating, :text, :created_at


          def sender_title
            object.sender_company_title
          end
          def recipient_title
            object.recipient_company_title
          end
          def created_at
            object.created_at.strftime( "%d %b %Y %H:%M")
          end

          def text
            object.first(20)
          end


        end
      end
    end

end
