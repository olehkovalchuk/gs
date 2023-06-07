module Admin 
  
    module Geo
      class RegionsController < Admin::ApplicationController
        work_with model: "::Geo::Region" do 
          # set_has_many_relations :countries, :ports
        end
      end
    end
  
end

