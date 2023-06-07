class AddDescriptionToMeatInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_invoices, :comment, :text
  end
end
