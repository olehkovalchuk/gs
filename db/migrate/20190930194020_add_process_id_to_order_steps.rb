class AddProcessIdToOrderSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :order_steps, :process_id, :integer, null:false
  end
end
