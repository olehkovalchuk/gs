module Admin 
  
    module Meat
      class QuickOffersController < Admin::ApplicationController
        work_with model: "::Meat::QuickOffer" do
          uncreatable
          actions none: true
        end
      end
    end
  
end

