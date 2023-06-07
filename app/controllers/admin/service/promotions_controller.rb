module Admin 
  
    module Service
      class PromotionsController < Admin::ApplicationController
        work_with model: "::Service::Promotion"
      end
    end
  
end

