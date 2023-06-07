class AddItemTypeToChatNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_notifications, :item_type, :string
  end
end
