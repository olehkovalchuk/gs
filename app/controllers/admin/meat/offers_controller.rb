module Admin

    module Meat
      class OffersController < Admin::ApplicationController
        work_with model: "::Meat::Offer" do
          uncreatable
        end





        def _prepare_form_data
          {
            origins: ::Geo::Country.order(code: :asc).all.map{|a| {title: a.title, id: a.code } },
            delivery_ports: ::Geo::Port.order(code: :asc).all.map{|a| {title: a.title, id: a.code } },
            certificates: ::Meat::Certificate.active.all.map{|a| {text: a.title, id: a.id } },
            documents: ::Meat::Document.all.map{|a| {text: a.title, id: a.id } },
            delivery_conditions: ::Delivery::Condition.active.all.map{|a| {text: a.code, id: a.code } },
            payment_types: ::Delivery::PaymentType.active.all.map{|a| {text: a.title, id: a.id } },
            packages: ::Delivery::Package.active.all.map{|a| {text: a.title, id: a.id } },
            permissions_to: ::Geo::Country.order(code: :asc).all.map{|a| {text: a.title, id: a.code } },
            payment_types: ::Delivery::PaymentType.active.all.map{|a| {text: a.title, id: a.id } },
            currencies: ["USD","EUR"].map{|i| {id: i, title: i } },
            categories: ::Meat::Category.pluck(:id,"title->'#{I18n.locale}'").map{|i| {id: i[0], title: i[1]} },
            weight_types:["KG","LB"].map{|i| {id: i, title: i} },
            length_types: ["CM"].map{|i| {id: i, title: i} },
            markets: AVAILABLE_MARKETPLACES.map{|i| {id: i, title: i} },
          }
        end



        def _setup_filter_variables
          @categories = ::Meat::Category.order("title->'#{I18n.locale}' ASC").pluck("title->'#{I18n.locale}'",:id)
        end

        private

        def _permited_attributes
          params.require(:item).permit( :id, :active, :plant_number, :delivery_port, :quantity, :currency, :price_from, :price_to, :description, :category_id, :origin, :weight_from, :weight_to, :length_from, :length_to, :weight_type, :length_type,  certificates: [], payment_types: [], documents: [], packages: [], delivery_conditions: []  )
        end


      end
    end

end




        # attribute :permissions_to, Array[String], default: []


        # attribute :images, Array[ActionDispatch::Http::UploadedFile], default: []
