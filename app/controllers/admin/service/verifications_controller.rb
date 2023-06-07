module Admin 
  
    module Service
      class VerificationsController < Admin::ApplicationController
        work_with model: "::Service::Verification"
      end
    end
  
end

