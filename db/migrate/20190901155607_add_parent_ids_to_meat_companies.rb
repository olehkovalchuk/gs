class AddParentIdsToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :category_ids, :integer, array: true, default: [], null:false
  end
end
