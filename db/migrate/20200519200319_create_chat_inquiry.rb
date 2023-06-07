class CreateChatInquiry < ActiveRecord::Migration[6.0]

  def change

    create_table :chat_inquiries do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string :sender_email, null: false
      t.string :title, null: false
      t.integer :recipient_company_id, null: false
      t.integer :recipient_company_user_id, null: false
      t.integer :sender_company_id
      t.integer :sender_company_user_id 

      t.integer :parent_id, null: false, default: 0
      t.string :receiver_email, null: false
      t.integer :inquirieable_id, null: false
      t.string :inquirieable_type, null: false
      t.text :message, null: false
      t.string :status, null: false, default: "created"
    end

  end
end

