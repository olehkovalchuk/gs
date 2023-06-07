
module Delivery
  module StepOperation
    class Base
      include Operation::Base
      crudify with: [:habtm, :habtm_update, :history] do
        model_name Step
      end
    end
  end
end

