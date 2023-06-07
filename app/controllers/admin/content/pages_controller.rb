module Admin 
  
    module Content
      class PagesController < Admin::ApplicationController
        work_with model: "::Content::Page"
      end
    end
  
end

