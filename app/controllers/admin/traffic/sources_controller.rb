module Admin 
  
    module Traffic
      class SourcesController < Admin::ApplicationController
        work_with model: "::Traffic::Source"
      end
    end
  
end

