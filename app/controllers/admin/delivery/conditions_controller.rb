module Admin

    module Delivery
      class ConditionsController < Admin::ApplicationController

        work_with model: "::Delivery::Condition" do
          set_has_many_relations :steps
          set_habtm_nested_relations( {steps: :step_fields} )
        end

      end
    end

end

