module Admin 
  
    module Geo
      class PortsController < Admin::ApplicationController
        work_with model: "::Geo::Port"

        private

        def _prepare_form_data
          {
            countries: ::Geo::Country.pluck(:code,"title->'#{I18n.locale}'").map{|i| {id: i[0], title: i[1]} }
          }
        end

        def _setup_filter_variables
          @countries = ::Geo::Country.pluck("title->'#{I18n.locale}'",:code)
          @regions = ::Geo::Region.pluck("title->'#{I18n.locale}'",:code)
        end

      end
    end
  
end

