module Admin 
  
    module Content
      class EmailTemplatesController < Admin::ApplicationController
        work_with model: "::Content::EmailTemplate"
      end
    end
  
end

