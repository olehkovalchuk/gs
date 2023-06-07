class AddMarketToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_categories, :market, :string, null: false, default: :meat
    add_column :meat_offers, :market, :string, null: false, default: :meat
    add_column :meat_requests, :market, :string, null: false, default: :meat
    add_column :delivery_packages, :markets, :string, array: true, default: AVAILABLE_MARKETPLACES, null: false
    add_column :meat_documents, :markets, :string, array: true, default: AVAILABLE_MARKETPLACES, null: false
    add_column :meat_certificates, :markets, :string, array: true, default: AVAILABLE_MARKETPLACES, null: false
    add_column :meat_companies, :markets, :string, array: true, default: AVAILABLE_MARKETPLACES, null: false
  end
end
