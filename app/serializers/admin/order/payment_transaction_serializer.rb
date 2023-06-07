module Admin

    module Order
      module PaymentTransactionSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id
        end
        class List < BeOneAdmin::Serializer


          self.sorting = {
            created_at: :created_at,
          }

          attribute :id, type: :hidden
          attribute :status, type: :enum
          attributes :description, :amount, :currency, :created_at, :company_title, :company_user_title
          attribute :status_text, type: :hidden

          def created_at
            object.created_at.strftime( "%d %b %Y %H:%M")
          end

          def status_text
            object.status
          end

        end
      end
    end

end

