class AddInquiryEmailToChatInquiries < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_inquiries, :inquiry_email, :string
  end
end
