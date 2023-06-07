class AddOriginToMeatOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_offers, :origin, :string, null:false, limit:2
    add_column :meat_requests, :origin, :string, limit:2
    add_column :meat_offers, :plain_permissions, :jsonb, default: [], null: false
    add_column :meat_requests, :plain_permissions, :jsonb, default: [], null: false

  end
end
