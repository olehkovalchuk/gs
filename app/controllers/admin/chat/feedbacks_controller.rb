module Admin

    module Chat
      class FeedbacksController < Admin::ApplicationController
        work_with model: "::Chat::Feedback" do
          uncreatable
        end
      end
    end

end

