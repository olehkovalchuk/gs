module Admin 
  
    module Chat
      class InquiriesController < Admin::ApplicationController
        work_with model: "::Chat::Inquiry" do 
          uncreatable
          actions with: [:send_mail, :toogle_request]
        end

        def send_mail
          process_and_respond!(operation: ::Chat::InquiryOperation::Send.new( id: params[:id] ) ) do |operation, result|
            render json: {success: true}
          end
        end

        def toogle_request
          process_and_respond!(operation: ::Chat::InquiryOperation::Read.new( id: params[:id] ) ) do |operation, result|
            operation.model.update!(post_request: !operation.model.post_request)
            render json: {success: true}
          end
        end

        def _setup_filter_variables
          @emails = ::Chat::Inquiry.pluck(:sender_email,:receiver_email).flatten.uniq.sort
        end

      end
    end
  
end

