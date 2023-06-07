class CreateOrderProcess < ActiveRecord::Migration[6.0]

  def change

    create_table :order_processes do |t|
      t.string "processable_type", null: false
      t.integer "processable_id", null: false
      t.integer "sender_company_id", null: false
      t.integer "sender_company_user_id", null: false
      t.integer "recipient_company_id", null: false
      t.integer "recipient_company_user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

