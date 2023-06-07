module Chat
  class MessagePresenter < BasePresenter
    def kibana_data
      {
        sender_company: @object.sender_company_title,
        recipient_company: @object.recipient_company_title,
      }
    end

    def is_sender?(user)
      @object.sender_id == user.id
    end

    def is_recipient?
      @object.recipient_id == user.id
    end
  end
end
