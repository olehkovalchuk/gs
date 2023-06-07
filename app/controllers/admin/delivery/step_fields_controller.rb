module Admin 
  
    module Delivery
      class StepFieldsController < Admin::ApplicationController
        work_with model: "::Delivery::StepField"


        def _prepare_form_data
          {
            field_types: ::Delivery::StepField.field_types.map{|i| {id: i[0], title: i[0]} }
          }
        end

      end
    end
  
end

