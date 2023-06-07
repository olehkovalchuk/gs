class AddItemTypeToPaymentTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :order_payment_transactions, :item_type, :string, null:false
    add_column :order_payment_transactions, :company_id, :integer, null:false
    add_column :order_payment_transactions, :company_user_id, :string, null:false

    add_column :meat_companies, :pasport_verified, :boolean, default:false
    add_column :meat_companies, :bill_verified, :boolean, default:false

    drop_table :meat_invoices
    create_table :meat_invoices do |t|
      t.integer :company_id, null:false, index: true
      t.integer :company_user_id, null:false, index: true
      t.integer :process_id
      t.string :status, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end
