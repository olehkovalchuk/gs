module Admin 
  
    module Geo
      class SeaLinesController < Admin::ApplicationController
        work_with model: "::Geo::SeaLine"
      end
    end
  
end

