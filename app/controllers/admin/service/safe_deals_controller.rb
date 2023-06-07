module Admin 
  
    module Service
      class SafeDealsController < Admin::ApplicationController
        work_with model: "::Service::SafeDeal"
      end
    end
  
end

