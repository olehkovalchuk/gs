class AddDefaultToOrderPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :order_packages, :default, :boolean, null:false, default: false
  end
end
