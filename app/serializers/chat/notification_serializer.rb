# == Schema Information
#
# Table name: chat_notifications
#
#  id                        :bigint           not null, primary key
#  action                    :string           not null
#  comment                   :string           not null
#  item_type                 :string
#  notificable_type          :string           not null
#  params                    :jsonb            not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  notificable_id            :integer          not null
#  recipient_company_id      :integer          not null
#  recipient_company_user_id :integer          not null
#  sender_company_id         :integer          not null
#  sender_company_user_id    :integer          not null
#
module Chat
  class NotificationSerializer
    class List < ActiveModel::Serializer
      attributes :id,:comment, :user, :created_at, :button

      def user
        Meat::CompanyUserSerializer::List.new(object.sender)
      end

      def created_at
        object.updated_at.strftime("%d %b %Y")
      end

      def button
        {
          text: I18n.t("common.notification_types.#{object.action.split('-').last}"),
          route: object.item_type,
          query: object.params,
          params: object.params
        }
      end

    end
  end
end
