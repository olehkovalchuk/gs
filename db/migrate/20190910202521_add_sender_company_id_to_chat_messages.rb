class AddSenderCompanyIdToChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_messages, :sender_company_id, :integer
    add_column :chat_messages, :recipient_company_id, :integer
  end
end
