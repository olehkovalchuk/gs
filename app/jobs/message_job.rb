class MessageJob < ApplicationJob
  def perform
    # Chat::Conversation.where(with_messages: false).delete_all
  end
end



 # Chat::Message.order(created_at: :asc).all.each do |message|
 #   if message.sender_company && message.recipient_company && message.recipient && message.sender
 #    Chat::Conversation.find_or_initialize_by(recipient_company_id: message.recipient_company_id, sender_company_id: message.sender_company_id, recipient_company_user_id: message.recipient_id, sender_company_user_id: message.sender_id).save!
 #   end
 # end