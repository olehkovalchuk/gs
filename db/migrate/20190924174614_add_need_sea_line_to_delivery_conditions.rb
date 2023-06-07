class AddNeedSeaLineToDeliveryConditions < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_conditions, :need_sea_line, :boolean, default: false
  end
end
