module Admin

    module Meat
      class CompaniesController < Admin::ApplicationController
        work_with model: "::Meat::Company" do
          has_image :logo
          uncreatable
          on_collection :export
        end

        include Admin::FormHelper

        def _prepare_form_data
          {
            ratings: form_choose.concat( ::Meat::Company.rating_codes.keys.map{|i| {id: i, title: i} }),
            countries: ::Geo::Country.pluck(:code,"title->'#{I18n.locale}'").map{|i| {id: i[0], title: i[1]} },
            roles: ["trader","seller","buyer"].map{|i| {id: i, title: i.capitalize } }
          }
        end

        def _setup_filter_variables
          @countries = ::Geo::Country.pluck("title->'#{I18n.locale}'",:code)
        end


        def delete_passport
          process_and_respond!(operation: ::Meat::CompanyOperation::DeleteDocument.new( id: params[:id], document: "passport" ) ) do |operation, result|
            render json: {success: true, message: 'Deleted'}
          end
        end

        def delete_bill
          process_and_respond!(operation: ::Meat::CompanyOperation::DeleteDocument.new( id: params[:id], document: "bill" ) ) do |operation, result|
            render json: {success: true, message: 'Deleted'}
          end
        end

      end
    end

end

