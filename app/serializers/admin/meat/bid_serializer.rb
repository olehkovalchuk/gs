module Admin

    module Meat
      module BidSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id
        end
        class List < BeOneAdmin::Serializer

          self.sorting = {
            created_at: :created_at,
          }

          attribute :id, type: :hidden
          attributes :bidable_type, :offer, :sender_title, :recipient_title
          attributes :amount, :currency, :comment, :created_at

          def offer
            return "<b>DELETED</b>" unless object.bidable
            "<a href='/marketplace/#{object.bidable_type.demodulize.downcase}s/#{object.bidable_id}' target='_blank'>#{object.bidable.category_title}</a>"
          end

          def bidable_type
            object.bidable_type.demodulize
          end

          def sender_title
            return "DELETED" unless object.sender
            object.sender.presenter.user_name
          end
          def recipient_title
            return "DELETED" unless object.recipient
            object.recipient.presenter.user_name
          end
          def created_at
            object.created_at.strftime( "%d %b %Y %H:%M")
          end
        end
      end
    end

end
