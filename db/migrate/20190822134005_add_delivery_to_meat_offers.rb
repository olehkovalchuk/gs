class AddDeliveryToMeatOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_offers, :delivery_type, :string
    add_column :meat_offers, :delivery_port, :string
    add_column :meat_offers, :delivery_country, :string

    add_column :meat_requests, :delivery_type, :string
    add_column :meat_requests, :delivery_port, :string
    add_column :meat_requests, :delivery_country, :string

  end
end
