module Admin

    module Meat
      module OfferSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active, :quantity, :currency, :price_from, :price_to, :description, :category_id, :origin, :plant_number, :delivery_port, :weight_from, :weight_to, :length_from, :length_to, :weight_type, :length_type
          attributes :certificates_tags, :payment_types_tags, :documents_tags, :delivery_conditions_tags, :packages_tags, :market


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

          def packages_tags
            object.presenter.packages_objects.map{|a| {text: a.title,id:a.id} }
          end

        end


        class List < BeOneAdmin::Serializer
          self.sorting = {
            created_at: :created_at,
          }

          
          attribute :id, type: :hidden
          as_image :logo
          attributes :market, :created_at, :category_title, :company_title, :price, :delivery



          def price
            object.presenter.price_formated(false, true)
          end
          def delivery
            object.presenter.delivery_formated
          end

          def logo
            image_path(object.images.first, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
          end

          def created_at
            object.created_at.to_s(:db)
          end

        end
      end
    end

end
