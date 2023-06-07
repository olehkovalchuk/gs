module Admin 
  
    module Meat
      class PromotionsController < Admin::ApplicationController
        work_with model: "::Meat::Promotion" do 
          uncreatable
          actions none: true
        end
      end
    end
  
end

