module Admin 
  
    module Service
      class UsageFeesController < Admin::ApplicationController
        work_with model: "::Service::UsageFee"
      end
    end
  
end

