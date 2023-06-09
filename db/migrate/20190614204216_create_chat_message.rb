class CreateChatMessage < ActiveRecord::Migration[6.0]

  def change

    create_table :chat_messages, if_not_exists: true do |t|

      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false
      t.integer :conversation_id, null: false
      t.text :text, null: false
      t.boolean :readed, default: false, null:false


      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

