class AddActiveForOffersToMeatCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_categories, :active_for_offers, :boolean, default: false
    add_column :meat_categories, :active_for_requests, :boolean, default: false
  end
end
