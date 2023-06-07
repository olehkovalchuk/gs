class AddCompletedAtToOrderSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :order_steps, :completed_at, :datetime
  end
end
