# == Schema Information
#
# Table name: meat_subscriptions
#
#  id              :bigint           not null, primary key
#  company_id      :integer          not null
#  company_user_id :integer          not null
#  category_ids    :integer          default([]), not null, is an Array
#  type            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
module Meat
  module SubscriptionSerializer
    class List < BeOneAdmin::Serializer
      DATE_FORMAT = "%d %b %Y"
      attributes :id,:created_at, :user, :type, :categories

      def created_at
        object.created_at.strftime(DATE_FORMAT)
      end

      def type
        I18n.t("common.#{object.type}")
      end

      def categories
        Meat::Category.where(id: object.category_ids).limit(3).map(&:title).join(",") + "..."
      end

      def user
        Meat::CompanyUserSerializer::Base.new(object.company_user)
      end

    end
  end
end
