class AddSafeDealToDeliveryConditions < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_conditions, :safe_deal, :boolean
  end
end
