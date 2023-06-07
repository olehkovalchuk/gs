module Chat
  class ConversationPresenter < BasePresenter
    def kibana_data
      {
        sender_company: @object.sender_company_title,
        sender_email: @object.sender.email,
        recipient_company: @object.recipient_company_title,
        recipient_email: @object.recipient.email,
      }
    end

    def is_sender?(user)
      @object.sender_company_user_id == user.id
    end

    def is_recipient?
      @object.recipient_company_user_id == user.id
    end

  end
end
