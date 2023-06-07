module Admin

    module Chat
      module ConversationSerializer

        class Message < BeOneAdmin::Serializer

          attributes :message_cls,:text, :bottom_text, :created_at, :logo, :sender

          def message_cls
            @instance_options[:current_user].company_id == self.object.sender_company_id ? 'left' : 'right'
          end

          def created_at
            format = if object.created_at < Date.today.beginning_of_day
              "%d %b %Y %H:%M"
            else
              "%H:%M"
            end
            object.created_at.strftime(format)
          end

          def bottom_text
            if self.object.file.attached?
              I18n.t("common.chat_file_name",name: self.object.file.filename, link: url_for(self.object.file) )
            elsif false
            end
          end

          def sender
            self.object.sender.presenter.user_name
          end

          def logo
            image_path(self.object.sender_company.logo)
          end
        end

        class Item < BeOneAdmin::Serializer
          attributes :id, :messages

          def messages
            ActiveModelSerializers::SerializableResource.new(
              object.messages,
              each_serializer: ::Admin::Chat::ConversationSerializer::Message,
              current_user: object.sender
            )
          end
        end
        class List < BeOneAdmin::Serializer
          self.sorting ={updated_at: :updated_at}
          attribute :id, type: :hidden
          attributes :sender_company_title, :sender_title,:recipient_company_title, :recipient_title, :updated_at
          attribute :has_new_messages, type: :state
          def has_new_messages
            object.messages.created.any?
          end

          def updated_at
            format = if object.updated_at < Date.today.beginning_of_day
              "%d %b %Y"
            else
              "%H:%M"
            end
            object.updated_at.strftime(format)
          end

        end
      end
    end

end

