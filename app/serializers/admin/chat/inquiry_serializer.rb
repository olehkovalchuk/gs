module Admin 
  
    module Chat
      module InquirySerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :message
        end
        class List < BeOneAdmin::Serializer

          self.sorting = {
            created_at: :created_at,
          }

          attribute :id, type: :hidden
          attributes :product, :created_at, :title, :sender_email, :phone, :receiver_email, :message

          attribute :status, type: :enum
          attribute :post_request, type: :state

          attribute :status_text, type: :hidden


          def created_at
            format = if object.created_at < Date.today.beginning_of_day
              "%d %b %Y %H:%M"
            else
              "%H:%M"
            end
            object.created_at.strftime(format)
          end

          def status_text
            object.status
          end

          def product
            return "<b>DELETED</b>" unless object.inquirieable
            "<a href='/marketplace/#{object.inquirieable_type.demodulize.downcase}s/#{object.inquirieable_id}' target='_blank'>#{object.inquirieable.category_title}</a>"
          end

        end
      end
    end
  
end

