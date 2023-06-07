module Admin 
  
    module Content
      class FaqsController < Admin::ApplicationController
        work_with model: "::Content::Faq"



        def _prepare_form_data
          {
            categories: ['marketplace','account','about'].map{|i| {id: i, title: i} }
          }
        end

      end
    end
  
end

