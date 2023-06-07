class AddCurrencyToMeatOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_offers, :currency, :string
    add_column :meat_requests, :currency, :string
    add_column :meat_offers, :price_type, :string, default: "MT"
    add_column :meat_requests, :price_type, :string, default: "MT"
  end
end
