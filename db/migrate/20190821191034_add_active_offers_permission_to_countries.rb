class AddActiveOffersPermissionToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_conditions, :active_for_offers, :boolean
    add_column :delivery_payment_types, :active_for_offers, :boolean
    add_column :delivery_conditions, :active_for_requests, :boolean
    add_column :delivery_payment_types, :active_for_requests, :boolean
    
  end
end
