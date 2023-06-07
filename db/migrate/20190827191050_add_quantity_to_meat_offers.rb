class AddQuantityToMeatOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_offers, :quantity, :float, null: false
    add_column :meat_offers, :quantity_type, :string, null: false, default: "T"
  end
end
