module Admin

    module Chat
      class ConversationsController < Admin::ApplicationController
        work_with model: "::Chat::Conversation" do
          uncreatable
          actions none: true
          order_by(updated_at: :desc)
          set_has_many_relations :messages
        end


        def _setup_filter_variables
          @companies = ::Meat::Company.pluck(:title,:id)
        end


      end
    end

end

