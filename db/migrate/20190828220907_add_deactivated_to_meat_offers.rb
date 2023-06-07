class AddDeactivatedToMeatOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_offers, :deleted, :boolean, default: false
    add_column :meat_requests, :deleted, :boolean, default: false
  end
end
