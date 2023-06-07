module Admin 
  
    module Geo
      class CountriesController < Admin::ApplicationController
        work_with model: "::Geo::Country"

        private

        def _prepare_form_data
          {
            regions: ::Geo::Region.pluck(:code,"title->'#{I18n.locale}'").map{|i| {id: i[0], title: i[1]} }
          }
        end

        def _setup_filter_variables
          @regions = ::Geo::Region.pluck("title->'#{I18n.locale}'",:code)
        end

      end
    end
  
end

