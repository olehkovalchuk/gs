module Admin

    module Meat
      module InvoiceSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active
          translated :title
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attribute :status, type: :enum
          attributes :company_title, :company_user_title, :comment, :created_at
          attributes :link
          attribute :status_text, type: :hidden

          def link
            "<a href='#{image_path(object.file)}' target='_blank'>Open</a>"
          end

          def status_text
            object.status
          end
        end
      end
    end

end

