class AddInTopToMeatOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_offers, :in_top, :boolean, default: false
    add_column :meat_requests, :in_top, :boolean, default: false
    add_column :meat_offers, :in_top_expire_at, :date
    add_column :meat_requests, :in_top_expire_at, :date
  end
end
