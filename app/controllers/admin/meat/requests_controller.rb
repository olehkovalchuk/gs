module Admin

    module Meat
      class RequestsController < Admin::ApplicationController
        work_with model: "::Meat::Request" do
          uncreatable
        end


        def _prepare_form_data
          {
            origins: ::Geo::Country.order(code: :asc).all.map{|a| {text: a.title, id: a.code } },
            certificates: ::Meat::Certificate.active.all.map{|a| {text: a.title, id: a.id } },
            documents: ::Meat::Document.all.map{|a| {text: a.title, id: a.id } },
            delivery_conditions: ::Delivery::Condition.active.all.map{|a| {text: a.code, id: a.code } },
            payment_types: ::Delivery::PaymentType.active.all.map{|a| {text: a.title, id: a.id } },
            permissions_to: ::Geo::Country.order(code: :asc).all.map{|a| {text: a.title, id: a.code } },

            currencies: ["USD","EUR"].map{|i| {id: i, title: i } },
            categories: ::Meat::Category.pluck(:id,"title->'#{I18n.locale}'").map{|i| {id: i[0], title: i[1]} },
            markets: AVAILABLE_MARKETPLACES.map{|i| {id: i, title: i} },

          }
        end



        def _setup_filter_variables
          @categories = ::Meat::Category.order("title->'#{I18n.locale}' ASC").pluck("title->'#{I18n.locale}'",:id)
        end

        private

        def _permited_attributes
          params.require(:item).permit( :id, :active, :quantity, :currency, :price_from, :price_to, :description, :category_id, certificates: [], payment_types: [], documents: [], origins: [], delivery_conditions: []  )
        end

      end
    end

end




