# == Schema Information
#
# Table name: order_payment_transactions
#
#  id              :bigint           not null, primary key
#  item_id         :integer          not null
#  status          :string           not null
#  description     :string           not null
#  amount          :float            not null
#  currency        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  item_type       :string           not null
#  company_id      :integer          not null
#  company_user_id :string           not null
#  system          :string           not null
#  system_id       :string
#  token           :string           not null
#
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

