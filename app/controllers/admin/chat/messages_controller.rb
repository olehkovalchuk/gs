module Admin

    module Chat
      class MessagesController < Admin::ApplicationController
        work_with model: "::Chat::Message" do
          # actions none: true
          order_by(created_at: :desc)
        end

        include Admin::FormHelper


        def _prepare_form_data
          {
            statuses: form_choose.concat( ::Chat::Message.statuses.keys.map{|i| {id: i, title: i} })
          }
        end


        private

        def _permited_attributes
          params.require(:item).permit( :id, :text, :status  )
        end

      end
    end

end

