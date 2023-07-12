
module Chat
  module ConversationOperation
    class Base
      include Operation::Base
      crudify except: [:destroy] do
        model_name Conversation
      end
    end

    class CabinetList < Base

      LIMIT = 15
      def perform
        relation = Chat::Conversation.page(form.page).where("sender_company_id = :id OR recipient_company_id = :id", id: form.current_user.company_id )
        relation = relation.where("sender_company_user_id = :id OR recipient_company_user_id", id: form.current_user.id ) unless form.current_user.presenter.is_company_owner?
        relation.order(updated_at: :desc).all.select{|m| m.messages.sent.any?}
      end
    end

    class Destroy < Base
      def perform
        Chat::Conversation.find(form.id).destroy
      end
    end

    class CreateDefault < Base
      def perform
        with_transaction do
          default_company = ::Meat::Company.find(::Setting.get("admin_company_id"))
          default_user = default_company.managers.first
          @model = Chat::Conversation.create!(
            deleted: false,
            sender_company_id: default_company.id,
            sender_company_user_id: default_user.id,
            recipient_company_id: form.company.id,
            recipient_company_user_id: form.company.managers.first.id,
            has_new_messages: true,
            recipient_new_messages: true
          )
          operation = Chat::MessageOperation::Create.new(
            current_user: default_user,
            conversation: @model,
            status: :sent,
            message: ::Setting.get("registration_message"),
          )
          operation.errors.each_pair{|k,v| pp k; add_error!(k,v)} unless operation.process

          ::Meat::CompanyUserOperation::UpdateMessages.new(id: @model.sender_company_user_id ).process
          ::Meat::CompanyUserOperation::UpdateMessages.new(id: @model.recipient_company_user_id ).process

          ::WhatsappSender.call(
            I18n.t('common.whatsapp.registration', {
              username: @model.recipient.presenter.user_name
            }),
            @model.recipient.phone
          )
        end
      end
    end

    class CreateDefaultInq < Base
      def perform
        with_transaction do
          default_company = ::Meat::Company.find(::Setting.get("admin_company_id"))
          default_user = default_company.managers.first
          @model = Chat::Conversation.create!(
            deleted: false,
            sender_company_id: inq.id,
            sender_company_user_id: default_user.id,
            recipient_company_id: form.company.id,
            recipient_company_user_id: form.company.managers.first.id,
            has_new_messages: true,
            recipient_new_messages: true,
          )
          operation = Chat::MessageOperation::Create.new(
            current_user: default_user,
            conversation: @model,
            status: :sent,
            message: ::Setting.get("registration_message"),
          )
          operation.errors.each_pair{|k,v| pp k; add_error!(k,v)} unless operation.process

          ::Meat::CompanyUserOperation::UpdateMessages.new(id: @model.sender_company_user_id ).process
          ::Meat::CompanyUserOperation::UpdateMessages.new(id: @model.recipient_company_user_id ).process

          ::WhatsappSender.call(
            I18n.t('common.whatsapp.inq_registration', {
              link: "https://globsupplies.com/marketplace/cabinet/conversations/#{@model.id}",
              username: @model.recipient.presenter.user_name
            }),
            @model.recipient.phone
          )
        end
      end
    end

    class AddMessage < Base
      def perform
        add_error!(:session_expired) unless form.current_user
        @model = ::Chat::Conversation.find_by(id: form.id)

        with_transaction do
          if @model

          else
            add_error!(:you_cant_send_message_to_yourself) if form.current_user.id == form.recepient_id
            recepient = Meat::CompanyUser.find(form.recepient_id)
            @model = form.current_user.created_conversations.find_by( recipient_company_user_id: recepient.id ) unless @model
            @model = form.current_user.received_conversations.find_by( sender_company_user_id: recepient.id ) unless @model
            
            unless @model
              add_error!(:you_need_subscription, 'You have reached your maximum chat count. Update your account to get more!') unless form.current_user.presenter.allowed_to_use?(:active_chats)
              @model = Chat::Conversation.create!(
                sender_company_id: form.current_user.company_id,
                sender_company_user_id: form.current_user.id,
                recipient_company_id: recepient.company_id,
                recipient_company_user_id: recepient.id,
                deleted: false
              )
              Meat::CompanyAction.update_limits(form.current_user.company, :active_chats) unless form.skip_limit
            end
          end
          if form.message.presence
            operation = Chat::MessageOperation::Create.new(
              current_user: form.current_user,
              conversation: @model,
              message: form.message,
              file: form.file,
              # status: form.sent ? :sent : :created
              status: :sent
            )
            operation.errors.each_pair{|k,v| pp k; add_error!(k,v)} unless operation.process

            ::Meat::CompanyUserOperation::UpdateMessages.new(id: @model.sender_company_user_id ).process
            ::Meat::CompanyUserOperation::UpdateMessages.new(id: @model.recipient_company_user_id ).process

            unless form.skip_limit
              ::WhatsappSender.call(
                I18n.t('common.whatsapp.chat_message', {
                  link: "https://globsupplies.com/marketplace/cabinet/conversations/#{@model.id}",
                }),
                operation.model.recipient.presenter.phone
              )
            end

            @model.sender.increment!(:outgoing_chats_count,1)
            @model.recipient.increment!(:incoming_chats_count,1)
            @model.sender.company.increment!(:outgoing_chats_count,1)
            @model.recipient.company.increment!(:incoming_chats_count,1)

            ::KibanaLogger.push("send_message", operation.model.presenter.kibana_data )
          else
            ::KibanaLogger.push("send_message", @model.presenter.kibana_data )
          end

          return operation ? operation.model : model
        end

      end
    end
  end
end
