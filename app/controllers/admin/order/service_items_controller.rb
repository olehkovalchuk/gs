module Admin 
  
    module Order
      class ServiceItemsController < Admin::ApplicationController
        work_with model: "::Order::ServiceItem" do 
          actions with: [:up,:down]
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

      end
    end
  
end

