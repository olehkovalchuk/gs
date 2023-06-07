module Admin 
  
    module Delivery
      class PackagesController < Admin::ApplicationController
        work_with model: "::Delivery::Package"

        def _prepare_form_data
          {
            markets: AVAILABLE_MARKETPLACES.map{|i| {id: i, title: i} },
          }
        end

        private

        def _permited_attributes
          params.require(:item).permit(:id, :active, market: {}, markets: [], title: {} ).tap do |pr|
            pr[:markets] = (pr[:market]&.keys || []).select { |key| pr[:market][key] }
          end
        end
      end
    end
  
end

