class AddActiveForOffersToGeoRegions < ActiveRecord::Migration[6.0]
  def change
    add_column :geo_regions, :active_for_offers, :boolean, default: true, null:false
    add_column :geo_regions, :active_for_requests, :boolean, default: true, null:false
    add_column :geo_regions, :active, :boolean, default: true, null:false
  end
end
