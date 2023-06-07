class AddZipToMeatCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :zip, :string
    add_column :meat_companies, :zip_address, :string
    add_column :meat_companies, :bank_country, :string, limit:2
    add_column :meat_companies, :bank, :string
    add_column :meat_companies, :city, :string
  end
end
