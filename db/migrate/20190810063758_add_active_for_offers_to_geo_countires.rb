class AddActiveForOffersToGeoCountires < ActiveRecord::Migration[6.0]
  def change
    enable_extension :ltree
    add_column :geo_countries, :active_offers_origin, :boolean, default: false
    add_column :geo_countries, :active_requests_origin, :boolean, default: false

    add_column :geo_countries, :active_offers_permission, :boolean, default: false
    add_column :geo_countries, :active_requests_permission, :boolean, default: false

    add_column :meat_categories, :path, :ltree

    add_index :meat_categories, :parent_id

  end
end
