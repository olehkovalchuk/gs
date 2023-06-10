# == Schema Information
#
# Table name: meat_company_users
#
#  id                         :bigint           not null, primary key
#  active                     :boolean          default(TRUE), not null
#  active_offers              :integer          default(0)
#  bids_in_count              :integer          default(0), not null
#  bids_out_count             :integer          default(0), not null
#  blocked                    :boolean          default(FALSE), not null
#  blocked_until              :datetime
#  country_code               :string(2)
#  deleted                    :boolean          default(FALSE)
#  email                      :string           not null
#  first_name                 :string           not null
#  incoming_chats_count       :integer          default(0), not null
#  incomming_invoice          :integer          default(0)
#  incomming_offer_views      :integer          default(0)
#  incomming_safe_deals_count :integer          default(0)
#  incomming_uniq_offer_views :integer          default(0)
#  is_company_owner           :boolean          default(FALSE), not null
#  last_name                  :string           not null
#  locale                     :string           default("en"), not null
#  new_messages_count         :integer          default(0), not null
#  new_notifications_count    :integer          default(0)
#  notifications_viewed_date  :datetime
#  offers_count               :integer          default(0), not null
#  otp_secret_key             :string
#  outgoing_chats_count       :integer          default(0), not null
#  outgoing_invoice           :integer          default(0)
#  outgoing_offer_views       :integer          default(0)
#  outgoing_safe_deals_count  :integer          default(0)
#  outgoing_uniq_offer_views  :integer          default(0)
#  password_digest            :text
#  phone                      :string
#  phone_number               :string
#  processes_count            :integer          default(0), not null
#  requests_count             :integer          default(0), not null
#  reset_password_expire_at   :datetime
#  reset_password_token       :string
#  signins_count              :integer          default(0), not null
#  title                      :string           not null
#  verificated_email          :boolean          default(FALSE), not null
#  verificated_phone          :boolean          default(FALSE), not null
#  verification_codes         :string           default([]), not null, is an Array
#  verification_expire        :datetime
#  wrong_password_attempts    :integer          default(0), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  company_id                 :integer          not null
#
# Indexes
#
#  index_meat_company_users_on_email_and_active  (email,active) UNIQUE
#
module Meat
  module CompanyUserSerializer
    class Base < BeOneAdmin::Serializer
      attributes :id, :avatar, :user_name, :new_messages_count, :can_add_member, :company_id, :processes_count, :offers_count, :requests_count, :is_company_owner, :alert_titles

      def avatar
        image_path(object.avatar, ActionController::Base.helpers.image_url("avatar.png"), "110x110")
      end

      def user_name
        object.presenter.user_name
      end

      def can_add_member
        object.presenter.can_add_member?
      end

      def alert_titles
        object.company&.alerts&.map(&:category_title) || []
      end

    end

    class List < Base
       attributes :id, :title, :user_name, :avatar


      def user_name
        "#{object.first_name} #{object.last_name}"
      end

    end


    class Charts < ActiveModel::Serializer
      include Chartable
    end

    class Full < Base
      attributes :id, :title, :first_name, :last_name, :phone, :email, :is_company_owner, :company_title

      attributes :processes_count, :offers_count, :requests_count, :country_code, :phone_number, :company

      def company
        Meat::CompanySerializer::Cabinet.new(object.company, current_user: object)
      end

      include Chartable

    end

    class Edit < BeOneAdmin::Serializer
      attributes :id, :avatar, :first_name, :last_name, :title, :phone_number, :country_code, :email, :phone, :user_name

      def avatar
        image_path(object.avatar, ActionController::Base.helpers.image_url("user.png"), "236x236")
      end
      def user_name
        object.presenter.user_name
      end
    end
  end
end


