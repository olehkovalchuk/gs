module Admin

    module Meat
      class InvoicesController < Admin::ApplicationController
        work_with model: "::Meat::Invoice" do
          uncreatable
          actions none: true
          actions with: [:approve,:decline]
        end

        def decline
          process_and_respond!(operation: ::Meat::InvoiceOperation::Update.new( id: params[:id], status: :rejected ) ) do |operation, result|
            render json: {success: true}
          end
        end

        def approve
          process_and_respond!(operation: ::Meat::InvoiceOperation::Update.new( id: params[:id], status: :approved ) ) do |operation, result|
            render json: {success: true}
          end
        end


        def _setup_filter_variables
          @companies = ::Meat::Company.pluck(:title,:id)
        end


      end
    end

end

