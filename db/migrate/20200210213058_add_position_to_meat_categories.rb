class AddPositionToMeatCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_categories, :position, :integer, default: 0
  end
end
