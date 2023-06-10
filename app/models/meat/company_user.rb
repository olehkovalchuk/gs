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
  class CompanyUser  < ApplicationRecord
    default_scope { where(deleted: false) }
    has_secure_password
    has_one_time_password
    signinable restrictions: [:ip, :user_agent]
    belongs_to :company
    belongs_to :country, foreign_key: :country_code, primary_key: :code, class_name: "::Geo::Country"
    has_many :offers
    has_many :requests
    has_many :bids

    has_many :created_conversations, class_name: "::Chat::Conversation", foreign_key: :sender_company_id, primary_key: :company_id
    has_many :received_conversations, class_name: "::Chat::Conversation", foreign_key: :recipient_company_id, primary_key: :company_id

    has_many :created_messages, class_name: "::Chat::Message", foreign_key: :sender_company_user_id
    has_many :received_messages, class_name: "::Chat::Message", foreign_key: :recipient_company_user_id

    has_many :payment_transactions, class_name: "::Order::PaymentTransaction", foreign_key: :company_user_id

    has_one_attached :avatar


    delegate :title, to: :company, prefix: true
  end
end
