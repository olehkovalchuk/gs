module Admin

    module Meat
      class CompanyUsersController < Admin::ApplicationController
        work_with model: "::Meat::CompanyUser" do
          has_image :avatar
          actions with: :otp
          # actions with: :go_to_company
          uncreatable
        end


        def otp
          process_and_respond!(operation: ::Meat::CompanyUserOperation::Read.new( id: params[:id] ) ) do |operation, result|
            render json: {success: true, message: result.otp_code}
          end
        end

        def go_to_company
          process_and_respond!(operation: ::Meat::CompanyUserOperation::Read.new( id: params[:id] ) ) do |operation, result|
            redirect_to "/admin/meat/companies/#{result.company_id}"
          end
        end


      end
    end

end

