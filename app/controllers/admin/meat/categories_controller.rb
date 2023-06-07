module Admin 
  
    module Meat
      class CategoriesController < Admin::ApplicationController
        work_with model: "::Meat::Category" do 
          # actions with: [:up,:down]
          has_image :image
        end
        include Admin::FormHelper

        def up 
          process_and_respond!(operation: ::Meat::CategoryOperation::Read.new( id: params[:id] ) ) do |operation, result|
            operation.model.up!
            render json: {success: true}
          end
        end

        def down 
          process_and_respond!(operation: ::Meat::CategoryOperation::Read.new( id: params[:id] ) ) do |operation, result|
            operation.model.down!
            render json: {success: true}
          end
        end

        private

        def _prepare_form_data
          {
            categories: form_choose.concat( ::Meat::Category.pluck(:id,"title->'#{I18n.locale}'").map{|i| {id: i[0], title: i[1]} }),
            markets: AVAILABLE_MARKETPLACES.map{|i| {id: i, title: i} },
          }
        end

        def _setup_filter_variables
          @parents = ::Meat::Category.order("title->'#{I18n.locale}' ASC").pluck("title->'#{I18n.locale}'",:id)
        end

      end
    end
  
end

