module Admin 
  
    module Delivery
      class PaymentTypesController < Admin::ApplicationController
        work_with model: "::Delivery::PaymentType"
      end
    end
  
end

