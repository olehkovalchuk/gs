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
