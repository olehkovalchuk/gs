class AddActiveToMeatOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_offers, :active, :boolean, default: false
    add_column :meat_requests, :active, :boolean, default: false
  end
end
