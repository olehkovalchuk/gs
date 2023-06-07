class AddIndexToDeliverySteps < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_steps, :position, :integer, null: false, default: 1
    add_column :delivery_steps, :seller_step, :boolean
    add_column :delivery_steps, :buyer_step, :boolean
    add_column :order_steps, :buyer_step, :boolean
    add_column :delivery_steps, :required_fields, :jsonb, null:false, default:[]
    rename_column :order_steps, :index, :position
  end
end
