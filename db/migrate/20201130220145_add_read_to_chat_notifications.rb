class AddReadToChatNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_notifications, :read, :boolean, default: false, null: false
  end
end
