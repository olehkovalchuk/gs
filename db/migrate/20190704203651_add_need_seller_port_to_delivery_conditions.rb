class AddNeedSellerPortToDeliveryConditions < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_conditions, :need_seller_port, :boolean, null: false, default: false
    add_column :delivery_conditions, :need_seller_country, :boolean, null: false, default: false
    add_column :delivery_conditions, :need_buyer_port, :boolean, null: false, default: false
    add_column :delivery_conditions, :need_buyer_country, :boolean, null: false, default: false

    remove_column :delivery_payment_types, :code ,:string
  end
end
