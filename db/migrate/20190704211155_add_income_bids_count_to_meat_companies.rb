class AddIncomeBidsCountToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :bids_in_count, :integer, null:false, default:0
    add_column :meat_companies, :bids_out_count, :integer, null:false, default:0
    add_column :meat_company_users, :bids_in_count, :integer, null:false, default:0
    add_column :meat_company_users, :bids_out_count, :integer, null:false, default:0

  end
end
