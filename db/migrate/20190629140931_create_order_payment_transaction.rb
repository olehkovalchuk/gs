class CreateOrderPaymentTransaction < ActiveRecord::Migration[6.0]

  def change

    create_table :order_payment_transactions do |t|
      t.integer :item_id, null:false
      t.string :status, null:false
      t.string :description, null:false
      t.float :amount, null: false
      t.string :currency, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

