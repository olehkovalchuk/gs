module Admin

    module Delivery
      class StepsController < Admin::ApplicationController
        work_with model: "::Delivery::Step" do
          set_habtm_relations :step_fields
        end

        def _prepare_form_data
          {
            positions: (1..20).to_a.map{|i| {id: i, title: i} }
          }
        end


      end
    end

end

