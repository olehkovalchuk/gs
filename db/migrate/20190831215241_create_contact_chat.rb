class CreateContactChat < ActiveRecord::Migration[6.0]

  def change

    drop_table :chat_notifications

    create_table :chat_notifications do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sender_company_id", null: false
      t.integer "sender_company_user_id", null: false
      t.integer "recipient_company_id", null: false
      t.integer "recipient_company_user_id", null: false
      t.string "comment", null: false
      t.string "action", null: false
      t.string "notificable_type", null: false
      t.integer "notificable_id", null: false
      t.jsonb :params, null:false, default:{}
    end
    
    create_table :contact_chats, force: :cascade do |t|
      t.string "email", null: false
      t.string "name", null: false
      t.text "text", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

