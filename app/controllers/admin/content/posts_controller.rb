module Admin 
  
    module Content
      class PostsController < Admin::ApplicationController
        work_with model: "::Content::Post" do 
          has_image :image
        end
      end
    end
  
end

