module Chat
  module MessageOperation
    class Base
      include Operation::Base
      crudify except: [:create] do
        model_name Message
      end
    end

    class CabinetList < Base
      def perform
        @model = Chat::Conversation.where("sender_company_id = :id OR recipient_company_id = :id", id: form.current_user.company_id ).find_by(id: form.id)
        @model = relation.find_by("sender_company_user_id = :id OR recipient_company_user_id", id: form.current_user.id ) unless form.current_user.presenter.is_company_owner?
        add_error!(:chat_not_found, "Chat not found") unless @model
        field = @model.presenter.is_sender?(form.current_user) ? :sender_new_messages : :recipient_new_messages

        @model.update(:has_new_messages => false, field => false )
        ::Meat::CompanyUserOperation::UpdateMessages.new(id: form.current_user.id ).process
        @model.messages.order(created_at: :asc).all.select{|m| m.presenter.is_sender?(form.current_user) || m.sent? }
      end
    end

    class Create < Base
      def perform
        ::KibanaLogger.push("send_message", form.conversation.presenter.kibana_data )
        @model = Chat::Message.new(
          sender_id: form.current_user.id,
          recipient_id: get_recipient.id,
          sender_company_id: form.current_user.company_id,
          recipient_company_id: get_recipient.company_id,
          conversation_id: form.conversation.id,
          text: form.message,
          status: form.status
        )
        add_error!(:cant_add_message, "Cant add message") unless @model.save
        @model.file.attach(form.file) if form.file
        trigger :after_create, @model, form
      end

      private

      def get_recipient
        form.conversation.recipient_company_user_id == form.current_user.id ? form.conversation.sender : form.conversation.recipient
      end

    end
  end
end
