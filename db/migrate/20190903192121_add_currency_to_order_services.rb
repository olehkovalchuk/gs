class AddCurrencyToOrderServices < ActiveRecord::Migration[6.0]
  def change
    add_column :offer_services, :currency, :string, null:false, default: "USD"
  end
end
