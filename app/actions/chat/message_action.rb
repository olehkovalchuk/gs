
module Chat
  module MessageAction
    extend self

    # def after_create(model,form)
    #   model.conversation.update(has_new_messages: true)
    #   model.update(status: :created)
    # end

    def after_create(model, form)
      return if model.recipient.reset_password_token.presence && model.text == ::Setting.get("registration_message")

      if model.sent?
        field = model.conversation.presenter.is_sender?(model.sender) ? :recipient_new_messages : :sender_new_messages
        model.conversation.update(:has_new_messages => true, field => true )

        UserMailer.chat_message( model.recipient, model).send(Rails.env.development? ? :deliver_now : :deliver_later )
        Chat::NotificationAction.send_notification( I18n.t("common.you_have_anew_message", from: model.sender_company.title), model.recipient.company_id )
      end      
    end


    # Available callbacks methods
    # after_save
    # before_save
    # after_create
    # before_create
    # after_destroy
    # before_destroy
    # after_update
    # before_update
  end
end



