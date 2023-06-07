class RemovePriceFromMeatOffers < ActiveRecord::Migration[6.0]
  def change
    remove_column :meat_offers, :price
    remove_column :meat_requests, :price
  end
end
