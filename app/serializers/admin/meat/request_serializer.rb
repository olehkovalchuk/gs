module Admin

    module Meat
      module RequestSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active, :quantity, :currency, :price_from, :price_to, :description, :category_id, :market
          attributes :certificates_tags, :payment_types_tags, :documents_tags, :delivery_conditions_tags, :origins_tags


          def certificates_tags
            object.presenter.certificates.map{|a| {text: a.title,id:a.id} }
          end

          def payment_types_tags
            object.presenter.payment_type_objects.map{|a| {text: a.title,id:a.id} }
          end

          def documents_tags
            object.presenter.documents_objects.map{|a| {text: a.title,id:a.id} }
          end

          def delivery_conditions_tags
            object.delivery_conditions.map{|a| {text: a ,id: a } }
          end

          def origins_tags
            object.presenter.origin_objects.map{|a| {text: a.title ,id: a.code } }
          end


        end
        class List < BeOneAdmin::Serializer

          self.sorting = {
            created_at: :created_at,
          }
          
          attribute :id, type: :hidden

          attributes :market, :category_title, :company_title, :price, :delivery, :created_at



          def price
            object.presenter.price_formated(false, true)
          end
          def delivery
            object.presenter.delivery_formated
          end

          def created_at
            object.created_at.to_s(:db)
          end

        end
      end
    end

end


