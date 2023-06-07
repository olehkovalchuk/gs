class AddPhoneToChatInquries < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_inquiries, :phone, :string
    add_column :chat_inquiries, :post_request, :boolean, default: false
    add_column :chat_inquiries, :country_code, :string, limit: 2
    add_column :chat_inquiries, :phone_number, :string
  end
end
