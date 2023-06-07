class AddTokenToOrderPaymentTransactions < ActiveRecord::Migration[6.0]
  def change
    Order::PaymentTransaction.delete_all
    add_column :order_payment_transactions, :token, :string, null:false
  end
end
