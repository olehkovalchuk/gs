class AddHasNewMessagesToChatConversations < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_conversations, :has_new_messages, :boolean, null:  false, default: true
  end
end
