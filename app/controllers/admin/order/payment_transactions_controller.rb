module Admin

    module Order
      class PaymentTransactionsController < Admin::ApplicationController
        work_with model: "::Order::PaymentTransaction" do
          # uncreatable
          # actions except: [:destroy]
        end

        def _setup_filter_variables
          @companies = ::Meat::Company.pluck(:title,:id)
        end

        def _prepare_form_data
          {
            companies: ::Meat::Company.all.map{|a| {title: a.title, id: a.id } },
            services: ::Order::Service.all.map{|a| {title: a.title, id: a.id } }
          }
        end


        def create
          process_and_respond!(operation: _operation(:force_create).new( _permited_attributes.merge(current_user: current_admin) ) ) do |operation, result|
            render json: {success: true}
          end
        end

        def _permited_attributes
          params.require(:item).permit( :company_id, :item_id )
        end

      end
    end

end

