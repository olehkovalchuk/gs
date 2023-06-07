module Admin

    module Chat
      class ContactsController < Admin::ApplicationController
        work_with model: "::Chat::Contact" do
          uncreatable
        end
      end
    end

end

