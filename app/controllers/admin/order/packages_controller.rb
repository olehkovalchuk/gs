module Admin 
  
    module Order
      class PackagesController < Admin::ApplicationController
        work_with model: "::Order::Package" do
          actions with: [:up,:down]
          has_image :file
        end

        def up
          process_and_respond!(operation: _operation(:up).new( id: params[:id] ) ) do |operation, result|
            render json: {success: true}
          end
        end

        def down
          process_and_respond!(operation: _operation(:down).new( id: params[:id] ) ) do |operation, result|
            render json: {success: true}
          end
        end
        include Admin::FormHelper

        def _prepare_form_data
          {
            usage_types: form_choose.concat( ::Meat::Company.rating_codes.keys.map{|i| {id: i, title: i} }),
            currencies: form_choose.concat( ["USD"].map{|i| {id: i, title: i} }),
          }
        end

        private

        def _permited_attributes
          params.require(:item).permit([
           :id,
           :active,
           :is_best,
           :map_access,
           :rating_code,
           :default,
           :price,
           :currency,
           :description,
           :offers_count,
           :requests_count,
           :received_inquries,
           :replyies_to_inquries,
           :active_chats,
           :show_infos,
           :buyer_allerts,
           :sub_accounts,
           :performance,
           :reports,
           :top_offers,
           :sended_inquries,
           :file_base64_data,
           title: {},
           offline_packages: {}]
           )
        end

      end
    end
  
end

