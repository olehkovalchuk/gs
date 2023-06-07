module Admin

    module Order
      class ItemsController < Admin::ApplicationController
        work_with model: "::Order::Item"
      end
    end

end

