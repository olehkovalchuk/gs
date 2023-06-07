class AddIncomeToChatChatInquiries < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_inquiries, :income, :boolean, default: true, null: true
    Chat::Inquiry.where(parent_id: [0,nil]).update_all(income: false)
  end
end
