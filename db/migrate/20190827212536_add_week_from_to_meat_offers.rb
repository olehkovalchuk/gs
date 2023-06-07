class AddWeekFromToMeatOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_offers, :week_from, :integer
    add_column :meat_offers, :week_to, :integer
    add_column :meat_requests, :quantity, :float, null: false
    add_column :meat_requests, :quantity_type, :string, null: false, default: "T"
  end
end
