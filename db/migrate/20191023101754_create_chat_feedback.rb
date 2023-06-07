class CreateChatFeedback < ActiveRecord::Migration[6.0]

  def change

    create_table :chat_feedbacks do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.text "text"
      t.integer "rating", null: false, default: 0
      t.jsonb "rating_extended", default: {}, null: false
      t.integer "sender_company_id", null: false
      t.integer "sender_company_user_id", null: false
      t.integer "recipient_company_id", null: false
      t.integer "recipient_company_user_id", null: false
      t.boolean "active", default: true
      t.boolean "deleted", default: true

    end

  end
end

