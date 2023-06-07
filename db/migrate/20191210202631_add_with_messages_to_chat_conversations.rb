class AddWithMessagesToChatConversations < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_conversations, :with_messages, :boolean, default: false
  end
end
