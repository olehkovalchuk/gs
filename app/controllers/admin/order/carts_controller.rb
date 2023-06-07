module Admin

    module Order
      class CartsController < Admin::ApplicationController
        work_with model: "::Order::Proces" do
          uncreatable
        end

        def _prepare_form_data
          {
            delivery_codes: ::Delivery::Condition.active.all.map{|a| {title: a.code, id: a.code } },
          }
        end

        helper_method :current_module_path
        protected


        def current_module_path
          controller = "#{@module.underscore}_carts"
          if BeOneAdmin::Engine.routes.named_routes.instance_variable_get("@url_helpers").to_a.include?(:"#{controller}_url")
            send("order_carts_path")
          else
            Rails.application.routes.url_helpers.send("#{BeOneAdmin.config.route}_#{controller}_path")
          end
        end



      end
    end

end

