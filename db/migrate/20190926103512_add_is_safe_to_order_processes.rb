class AddIsSafeToOrderProcesses < ActiveRecord::Migration[6.0]
  def change
    add_column :order_proceses, :is_safe, :boolean
  end
end
