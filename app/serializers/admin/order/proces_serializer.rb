module Admin

    module Order
      module ProcesSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :delivery_code
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden

          attributes :process_id, :sender_company_title, :sender_title,:recipient_company_title, :recipient_title, :offer

          attributes :stage
          attribute :status_text, type: :hidden

          attribute :status, type: :enum

          def status_text
            object.status
          end

          def offer
            "<a href='/marketplace/#{object.processable_type.demodulize.downcase}s/#{object.processable_id}' target='_blank'>#{object.processable.category_title}</a>"
          end


        end
      end
    end

end
