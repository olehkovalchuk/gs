module Admin

    module Chat
      class SubscribersController < Admin::ApplicationController
        work_with model: "::Subscriber" do
          uncreatable
          actions none: true
          on_collection :export
        end

      end
    end

end

