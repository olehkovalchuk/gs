class AddClsToMeatCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_categories, :cls, :string
  end
end
