class CreateChatNotification < ActiveRecord::Migration[6.0]

  def change

    create_table :chat_notifications do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.text :text, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

