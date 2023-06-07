class AddHasPrepayToDeliveryPaymentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_payment_types, :has_prepay, :boolean, default: false
    add_column :meat_documents, :active_for_offer, :boolean, default: true
    add_column :meat_documents, :active_for_po, :boolean, default: true
    add_column :meat_documents, :need_sign, :boolean, default: false
  end
end
