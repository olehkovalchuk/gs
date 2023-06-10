# == Schema Information
#
# Table name: chat_conversations
#
#  id                        :bigint           not null, primary key
#  sender_company_id         :integer          not null
#  sender_company_user_id    :integer          not null
#  recipient_company_id      :integer          not null
#  recipient_company_user_id :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  active                    :boolean          default(TRUE)
#  deleted                   :boolean          default(TRUE)
#  has_new_messages          :boolean          default(TRUE), not null
#  with_messages             :boolean          default(FALSE)
#  sender_new_messages       :boolean          default(FALSE)
#  recipient_new_messages    :boolean          default(FALSE)
#
module Chat
  class ConversationSerializer
    class List < ActiveModel::Serializer
      attributes :id,:last_message, :company, :updated_at, :has_new_messages

      def company
        _company =  @instance_options[:current_user].company_id == self.object.sender_company_id ? self.object.recipient_company : self.object.sender_company
        Meat::CompanySerializer::Mini.new(_company, current_user: @instance_options[:current_user])
      end

      def last_message
        object.messages.sent.last&.text
      end

      def has_new_messages
        field = object.presenter.is_sender?(@instance_options[:current_user]) ? :sender_new_messages : :recipient_new_messages
        object.send(field)
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

