module Order
  module PaymentTransactionSerializer
    class List < ActiveModel::Serializer
      attributes :id, :status, :amount, :currency, :item_type, :description, :created_at, :user
      DATE_FORMAT = "%d %b %Y %H:%M"
      def id
        object.id.to_s.rjust(5, '0')
      end

      def status
        I18n.t("common.transaction_statuses.#{object.status}")
      end

      def item_text
        I18n.t("common.order_types.#{object.item_type}")
      end

      def created_at
        object.created_at.strftime(DATE_FORMAT)
      end

      def item_type
        "verification"
      end

      def user
        Meat::CompanyUserSerializer::Base.new(object.company_user)
      end
    end
  end
end

