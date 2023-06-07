class AddSenderNewMessagesToChatConversations < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_conversations, :sender_new_messages, :boolean, default: false
    add_column :chat_conversations, :recipient_new_messages, :boolean, default: false
  end
end
