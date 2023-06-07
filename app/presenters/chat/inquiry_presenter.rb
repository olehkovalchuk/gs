module Chat
  class InquiryPresenter < BasePresenter
    def kibana_data
      {
        sender_company: @object.sender_company_title,
        sender_company_email: @object.sender.email,
        recipient_company: @object.recipient_company_title,
        recipient_company_email: @object.recipient.email,
      }
    end
  end
end
