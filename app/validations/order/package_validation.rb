
module Order
  module PackageValidation
    class Base 
      include Validation::Base
      crudify do 
        attribute :rating_code, String, default: "fresh"
        attribute :active, Boolean, default: false
        attribute :is_best, Boolean, default: false
        attribute :map_access, Boolean, default: false
        attribute :default, Boolean, default: false

        attribute :currency, String
        attribute :price, Float
        attribute :days, Integer

        attribute :offers_count, Integer, default: 0
        attribute :requests_count, Integer, default: 0
        attribute :received_inquries, Integer, default: 0
        attribute :replyies_to_inquries, Integer, default: 0
        attribute :active_chats, Integer, default: 0
        attribute :show_infos, Integer, default: 0
        attribute :buyer_allerts, Integer, default: 0
        attribute :sub_accounts, Integer, default: 0
        attribute :top_offers, Integer, default: 0
        attribute :sended_inquries, Integer, default: 0
        attribute :description, String, default: ""

        attribute :rating_code, String, default: "fresh"

        attribute :performance, String, default: ""
        attribute :reports, String, default: ""

        attribute :offline_packages, Hash

        attribute :file
        multilang_attribute :title
        validate :title_multilang_presence

        validates :price, :days, presence: true
        validates :offers_count, :requests_count, :received_inquries, :replyies_to_inquries, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
        validates :active_chats, :show_infos, :buyer_allerts, :sub_accounts, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
        validates :top_offers, :sended_inquries, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

      end
    end

    class Pay < Read
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :discount, Boolean, default: false
      # validates :current_user, presence: true
    end
  end
end

