class AddDaysToOrderPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :order_packages, :days, :integer, null: false, default: 30
  end
end
