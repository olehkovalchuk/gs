class CreateOrderItem < ActiveRecord::Migration[6.0]

  def change

    create_table :order_items do |t|
      t.string :orderable_type, null: false
      t.integer :orderable_id, null: false
      t.integer :company_id, null: false
      t.integer :company_user_id, null: false
      t.float :total_price, null: false
      t.string :currency, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

