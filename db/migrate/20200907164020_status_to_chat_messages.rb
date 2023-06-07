class StatusToChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_messages, :status, :string, null: false, default: 'sent'
  end
end
