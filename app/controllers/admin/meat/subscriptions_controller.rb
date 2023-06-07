module Admin 
  
    module Meat
      class SubscriptionsController < Admin::ApplicationController
        work_with model: "::Meat::Subscription"
      end
    end
  
end

