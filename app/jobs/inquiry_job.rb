class InquiryJob < ApplicationJob
  def perform
    Gmail.connect!(Rails.application.secrets[:inquiry][:user_name], Rails.application.secrets[:inquiry][:password]) do |gmail|

      gmail.inbox.find(:unread).each do |email|
        next unless receiver = email.to.find{|r| r.mailbox.match(/inquiries/) }
        next unless parent_inqury = ::Chat::Inquiry.find_by(inquiry_email: "#{receiver.mailbox}@globsupplies.com")

        Chat::InquiryOperation::Create.new(
          sender_email: parent_inqury.receiver_email,
          receiver_email: parent_inqury.sender_email,
          title: email.subject,
          message: email.text_part ? email.text_part.body.decoded.gsub("\n", ' ').squeeze(' ') : nil,
          inquirieable_type: parent_inqury.inquirieable_type,
          inquirieable_id: parent_inqury.inquirieable_id,
          sender_company_id: parent_inqury.sender_company_id,
          sender_company_user_id: parent_inqury.sender_company_user_id,
          recipient_company_id: parent_inqury.recipient_company_id,
          recipient_company_user_id: parent_inqury.recipient_company_user_id,
          with_recount: false
        ).process
        email.read!
      end
    end
  end
end

