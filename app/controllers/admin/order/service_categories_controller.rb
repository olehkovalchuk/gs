module Admin 
  
    module Order
      class ServiceCategoriesController < Admin::ApplicationController
        work_with model: "::Order::ServiceCategory" do 
          set_has_many_relations :service_items
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

