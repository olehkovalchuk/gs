class CreateMeatBid < ActiveRecord::Migration[6.0]

  def change

    create_table :meat_bids do |t|
      t.string :currency, null: false 
      t.float :amount, null: false 
      t.string :comment
      t.string "bidable_type", null: false
      t.integer "bidable_id", null: false
      t.integer :sender_company_id, null: false
      t.integer :sender_company_user_id, null: false
      t.integer :recipient_company_id, null: false
      t.integer :recipient_company_user_id, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

