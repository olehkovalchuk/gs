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



