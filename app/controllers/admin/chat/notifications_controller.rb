module Admin

    module Chat
      class NotificationsController < Admin::ApplicationController
        work_with model: "::Chat::Notification" do
          uncreatable
        end


        def _setup_filter_variables
          @companies = ::Meat::Company.pluck(:title,:id)
        end

      end
    end

end

