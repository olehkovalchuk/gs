class AddRoleToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :role, :string, null: false, default: "trader"
    add_column :meat_companies, :about, :text
    add_column :meat_companies, :address, :string
    add_column :meat_companies, :total_emploees, :integer
    add_column :meat_companies, :year_establishment, :integer
    add_column :meat_companies, :success_deal, :integer, default: 0, null: false
    add_column :meat_companies, :plant_number, :string
    add_column :meat_companies, :representative, :string

    add_column :meat_offers, :price_from, :integer, default: 0, null: false
    add_column :meat_offers, :price_to, :integer, default: 0, null: false

    add_column :meat_requests, :price_from, :integer, default: 0, null: false
    add_column :meat_requests, :price_to, :integer, default: 0, null: false

  end
end

