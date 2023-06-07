module Admin 
  
    module Meat
      class DocumentsController < Admin::ApplicationController
        work_with model: "::Meat::Document"


        def _prepare_form_data
          {
            templates: ["po","contract"].map{|a| {title: a, id: a } },
            markets: AVAILABLE_MARKETPLACES.map{|i| {id: i, title: i} },
          }
        end
        
        private

        def _permited_attributes
          params.require(:item).permit(:id,:active_for_offer,:active_for_po,:need_sign,:need_before_sign, :template,market:{},markets:[],title: {}).tap do |pr|
            pr[:markets] = (pr[:market]&.keys || []).select { |key| pr[:market][key] }
          end
        end

      end
    end
  
end

