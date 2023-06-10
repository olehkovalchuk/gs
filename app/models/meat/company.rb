# == Schema Information
#
# Table name: meat_companies
#
#  id                         :bigint           not null, primary key
#  about                      :text
#  account_number             :string
#  active                     :boolean          default(TRUE)
#  active_chats_limit         :integer          default(0), not null
#  active_chats_used          :integer          default(0)
#  active_offers              :integer          default(0)
#  address                    :string
#  bank                       :string
#  bank_country               :string(2)
#  bids_in_count              :integer          default(0), not null
#  bids_out_count             :integer          default(0), not null
#  bill_verified              :boolean          default(FALSE)
#  blocked                    :boolean          default(FALSE)
#  blocked_until              :datetime
#  buyer_allerts_limit        :integer          default(0), not null
#  buyer_allerts_used         :integer          default(0)
#  category_ids               :integer          default([]), not null, is an Array
#  certificates               :integer          default([]), not null, is an Array
#  city                       :string
#  country_code               :string(2)
#  eori                       :string
#  iban                       :string
#  incoming_chats_count       :integer          default(0), not null
#  incomming_invoice          :integer          default(0)
#  incomming_offer_views      :integer          default(0)
#  incomming_safe_deals_count :integer          default(0)
#  incomming_uniq_offer_views :integer          default(0)
#  latitude                   :float            default(0.0), not null
#  longitude                  :float            default(0.0), not null
#  managers_count             :integer          default(0), not null
#  markets                    :string           default(["\"meat\""]), not null, is an Array
#  moderated                  :boolean          default(TRUE)
#  new_messages_count         :integer          default(0), not null
#  offers_count               :integer          default(0), not null
#  offers_count_limit         :integer          default(0), not null
#  offers_count_used          :integer          default(0)
#  offers_limit               :integer          default(0), not null
#  offers_used                :integer          default(0)
#  on_map                     :boolean          default(FALSE)
#  outgoing_chats_count       :integer          default(0), not null
#  outgoing_invoice           :integer          default(0)
#  outgoing_offer_views       :integer          default(0)
#  outgoing_safe_deals_count  :integer          default(0)
#  outgoing_uniq_offer_views  :integer          default(0)
#  package_expiration         :date             default(Fri, 30 Jun 2023), not null
#  pasport_verified           :boolean          default(FALSE)
#  phone                      :string
#  phone_number               :string
#  plant_number               :string
#  processes_count            :integer          default(0), not null
#  rating                     :integer          default(0), not null
#  rating_code                :string           default("fresh"), not null
#  rating_extended            :jsonb            not null
#  received_inquries_limit    :integer          default(0), not null
#  received_inquries_used     :integer          default(0)
#  replyies_to_inquries_limit :integer          default(0), not null
#  replyies_to_inquries_used  :integer          default(0)
#  representative             :string
#  requests_count             :integer          default(0), not null
#  requests_count_limit       :integer          default(0), not null
#  requests_count_used        :integer          default(0)
#  role                       :string           default("trader"), not null
#  sended_inquries_limit      :integer          default(0), not null
#  sended_inquries_used       :integer          default(0)
#  seo_name                   :string           not null
#  show_infos_limit           :integer          default(0), not null
#  show_infos_used            :integer          default(0)
#  sub_accounts_limit         :integer          default(0), not null
#  sub_accounts_used          :integer          default(0)
#  success_deal               :integer          default(0), not null
#  swift                      :string
#  tic                        :string
#  title                      :string           not null
#  top_offers_limit           :integer          default(0), not null
#  top_offers_used            :integer          default(0)
#  total_emploees             :integer
#  used_ininquies_count       :integer          default(0), not null
#  vat                        :string
#  year_establishment         :integer
#  zip                        :string
#  zip_address                :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_meat_companies_on_seo_name  (seo_name)
#
module Meat
  class Company  < ApplicationRecord
    DEFAULT_RATING_CODE = "fresh"
    enum rating_code: {
      DEFAULT_RATING_CODE => DEFAULT_RATING_CODE,
      bronze: "bronze",
      silver: "silver",
      gold: "gold",
      platinum: "platinum",
    }

    RATINGS = {
      bronze: 0,
      silver: 51,
      gold: 71,
      platinum: 81,
    }
    has_one_attached :logo

    has_one_attached :passport
    has_one_attached :bill

    belongs_to :country, foreign_key: :country_code, primary_key: :code, class_name: "::Geo::Country"
    belongs_to :country_bank, foreign_key: :bank_country, primary_key: :code, class_name: "::Geo::Country", optional: true
    delegate :title, to: :country, prefix: true
    delegate :title, to: :country_bank, prefix: true, allow_nil: true

    has_many :managers, class_name: "::Meat::CompanyUser", foreign_key: :company_id, dependent: :delete_all
    has_many :invoices, class_name: "::Meat::Invoice", foreign_key: :company_id, dependent: :delete_all

    has_many :alerts, class_name: "::Meat::Alert", foreign_key: :company_id, dependent: :delete_all

    has_many :bids, class_name: "::Meat::Bid", foreign_key: :sender_company_id, dependent: :delete_all
    has_many :processes, class_name: "::Order::Proces", foreign_key: :company_id, dependent: :delete_all

    has_many :transactions, class_name: "::Order::PyamentTransaction", foreign_key: :company_id, dependent: :delete_all
    has_many :offers, class_name: "::Meat::Offer", foreign_key: :company_id, dependent: :delete_all
    has_many :requests, class_name: "::Meat::Request", foreign_key: :company_id, dependent: :delete_all

    has_many :created_conversations, class_name: "::Chat::Conversation", foreign_key: :sender_company_id, dependent: :delete_all
    has_many :received_conversations, class_name: "::Chat::Conversation", foreign_key: :recipient_company_id, dependent: :delete_all

    has_many :payment_transactions, class_name: "::Order::PaymentTransaction", foreign_key: :company_id
    has_many :notifications, as: :notificable, class_name: "::Chat::Notification", dependent: :delete_all


  end
end



