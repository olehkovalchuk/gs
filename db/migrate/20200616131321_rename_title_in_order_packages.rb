class RenameTitleInOrderPackages < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_service_categories, :title
    remove_column :order_service_items, :title
    remove_column :order_packages, :title

    add_column :order_service_categories, :title, :jsonb, null: false, default: {}
    add_column :order_service_items, :title, :jsonb, null: false, default: {}
    add_column :order_packages, :title, :jsonb, null: false, default: {}

  end
end
