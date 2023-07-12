module Chat
  module InquiryOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Inquiry
      end
    end

    class Send < Read

      def perform
        return if model.sent?

        model.sent!
        unless model.parent
          UserMailer.inquiry( model.recipient, I18n.t("common.you_have_anew_inquiry", from: model.title), model ).send(Rails.env.development? ? :deliver_now : :deliver_later )
        # Meat::CompanyAction.update_limits(model.recipient_company, :received_inquries)
          Chat::ConversationOperation::AddMessage.new(
            message: model.message,
            # recepient_id: model.recipient.id,
            # current_user: model.sender.presenter,
            recepient_id: model.title.starts_with?('Re:') ? model.sender.id : model.recipient.id,
            current_user: model.title.starts_with?('Re:') ? model.recipient.presenter : model.sender.presenter,
            skip_limit: true,
            sent: true
          ).process

          Meat::RequestOperation::CreateFromOffer.(id: model.inquirieable_id, current_user: model.sender) if model.post_request

          ::WhatsappSender.call(
            I18n.t('common.whatsapp.new_inq', {
              link: "https://globsupplies.com/marketplace/cabinet/conversations",
              text: model.message,
              title: model.inquirieable.category_title,
              username: model.recipient.presenter.user_name
            }),
            model.title.starts_with?('Re:') ? model.sender.phone : model.recipient.phone
          )
        end
        true
      end

    end

    class Replay < Base

      def perform
        parent_inqury ||= ::Chat::Inquiry.find_by(inquiry_email: "inquiries+#{form.id}@globsupplies.com")

        add_error!(:replyies_to_inquries, 'You have reached your limit of inquiries. To get more limmits, upgrade your membership') unless parent_inqury.recipient_company.presenter.allowed_to_use?(:replyies_to_inquries)

        inqury = Chat::InquiryOperation::Create.new(
          sender_email: parent_inqury.receiver_email,
          receiver_email: parent_inqury.sender_email,
          title: "Re:#{parent_inqury.title}",
          message: form.message,
          parent_id: parent_inqury.id,
          inquirieable_type: parent_inqury.inquirieable_type,
          inquirieable_id: parent_inqury.inquirieable_id,
          sender_company_id: parent_inqury.sender_company_id,
          sender_company_user_id: parent_inqury.sender_company_user_id,
          recipient_company_id: parent_inqury.recipient_company_id,
          recipient_company_user_id: parent_inqury.recipient_company_user_id,
          with_recount: false,
          phone: parent_inqury.sender.phone,
          phone_number: parent_inqury.sender.phone_number,
          country_code: parent_inqury.sender.country_code
        ).run

        ::Chat::InquiryOperation::Send.new(id: inqury.id).perform
        
        RequestStore.store[:kibana_data].merge!(
          current_email: parent_inqury.receiver_email,
          current_company: inqury.recipient_company.try(:title)
        )

        ::KibanaLogger.push("inqury_replay", parent_inqury.presenter.kibana_data )


        Meat::CompanyAction.update_limits(inqury.recipient_company, :replyies_to_inquries)

      end

    end

  end
end
