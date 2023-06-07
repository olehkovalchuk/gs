module Admin 
  
    module Meat
      class CertificatesController < Admin::ApplicationController
        work_with model: "::Meat::Certificate" do 
          has_image :logo
        end


        def _prepare_form_data
          {
            markets: AVAILABLE_MARKETPLACES.map{|i| {id: i, title: i} },
          }
        end
        
        private

        def _permited_attributes
          params.require(:item).permit(:id, :active, :logo_base64_data, :logo, market:{}, markets: [], title: {} ).tap do |pr|
            pr[:markets] = (pr[:market]&.keys || []).select { |key| pr[:market][key] }
          end
        end

      end
    end
  
end

