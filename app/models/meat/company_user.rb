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
