class AddSystemToOrderPaymentTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :order_payment_transactions, :system, :string, null:false
    add_column :order_payment_transactions, :system_id, :string
  end
end
