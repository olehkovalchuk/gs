class AddUsedIninquiesToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :used_ininquies_count, :integer, default:0, null:false
  end
end
