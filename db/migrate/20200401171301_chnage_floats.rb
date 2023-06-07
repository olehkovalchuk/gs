class ChnageFloats < ActiveRecord::Migration[6.0]
  def change
    change_column :meat_offers, :weight_from, :float
    change_column :meat_offers, :weight_to, :float
    change_column :meat_offers, :length_from, :float
    change_column :meat_offers, :length_to, :float
    change_column :meat_offers, :price_from, :float
    change_column :meat_offers, :price_to, :float
    change_column :meat_requests, :price_from, :float
    change_column :meat_requests, :price_to, :float
  end
end
