module Admin 
  
    module Meat
      class BidsController < Admin::ApplicationController
        work_with model: "::Meat::Bid" do 
          uncreatable
        end
      end
    end
  
end

