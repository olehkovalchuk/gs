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
  module CompanySerializer
    class Mini < BeOneAdmin::Serializer
      attributes :id,:logo, :title, :rating_code, :role, :seo_title
      DEFAULT = "/avatar.png"
      def logo
        image_path( nil, "/flags/#{object.country_code.upcase}.svg", "60x60") 
      end
      def title 
        object.presenter.title_formated(@instance_options[:current_user].presence)
      end

      def seo_title
        object.presenter.title_formated(true)
      end
    end
    class Po < Mini
      attributes :zip_address, :address, :account_number , :country_code, :phone, :phone_number, :info
      def info
        infos = [
          {title: I18n.t("common.company_info.role"), value: I18n.t("common.company_info.roles.#{object.role}") }
        ]
        infos << {title: I18n.t("common.company_info.country"), value: object.country_title} if object.country_code
        infos << {title: I18n.t("common.company_info.address"), value: object.address} if object.address.presence
        infos << {title: I18n.t("common.company_info.about"), value: object.about} if object.about.presence

        infos << {title: I18n.t("common.company_info.total_emploees"), value: object.total_emploees} if object.total_emploees.presence
        infos << {title: I18n.t("common.company_info.year_establishment"), value: object.year_establishment} if object.year_establishment.presence
        infos << {title: I18n.t("common.company_info.success_deal"), value: object.success_deal} unless object.success_deal.zero?
        infos << {title: I18n.t("common.company_info.plant_number"), value: object.plant_number} if object.plant_number.presence

        infos

      end

    end



    class Short < Mini
      attributes :processes_count, :offers_count, :requests_count, :on_map, :category_ids, :images
      attributes :r_id, :position

      def r_id
        object.managers.find_by(is_company_owner:true).id
      end

      def position
        {
          lat: object.latitude,
          lng: object.longitude,
        }
      end
      def images
        object.offers.map(&:images).flatten.map{ |i| image_path(i, nil, "80x80") }.compact.take(3)
      end
    end

    class Cabinet < Mini
      attributes :limits, :package_expiration

      DEFAULT = "/avatar.png"
      def logo
        image_path( object.logo, DEFAULT, "60x60") 
      end

      def limits
        [
        {title:  "Posted offers", tooltip: "common.pricing_tooltip.posted_offers", used: object.offers_count_used, max: object.offers_count_limit},
        {title:  "Posted requests", tooltip: "common.pricing_tooltip.posted_requests", used: object.requests_count_used, max: object.requests_count_limit},
        {title:  "Incoming inquiries", tooltip: "common.pricing_tooltip.incoming_inquiries", used: object.received_inquries_used, max: object.received_inquries_limit},
        {title:  "Outcoming inquiries", tooltip: "common.pricing_tooltip.outcoming_inquiries", used: object.sended_inquries_used, max: object.sended_inquries_limit},
        {title:  "Chat quantity", tooltip: "common.pricing_tooltip.chat_quantity", used: object.active_chats_used, max: object.active_chats_limit},
        {title:  "Show contact info", tooltip: "common.pricing_tooltip.show_contact_info", used: object.show_infos_used, max: object.show_infos_limit},
        {title:  "Promoted offers", tooltip: "common.pricing_tooltip.promoted_offers", used: object.top_offers_used, max: object.top_offers_limit},
        {title:  "Active buyer alerts", tooltip: "common.pricing_tooltip.active_buyer_alerts", used: object.buyer_allerts_used, max: object.buyer_allerts_limit},
        {title:  "Sub accounts limit", tooltip: "common.pricing_tooltip.sub_accounts_limit", used: object.sub_accounts_used, max: object.sub_accounts_limit},
        {title:  "Replay to inquiries", tooltip: "common.pricing_tooltip.reply_to_inquiries", used: object.replyies_to_inquries_used, max: object.replyies_to_inquries_limit},

        ]
      end
    end

    class MapList <  Mini
      attributes :r_id, :position, :images, :category_ids

      def images
        object.offers.map(&:images).flatten.map{ |i| image_path(i, nil, "80x80") }.compact.take(3)
      end

      def r_id
        object.managers.find_by(is_company_owner:true).id
      end
      def position
        {
          lat: object.latitude,
          lng: object.longitude,
        }
      end
    end

    class Edit < Short
      attributes :country_code, :role, :about, :address, :total_emploees, :year_establishment, :plant_number, :representative
      attributes :iban, :swift, :tic, :vat, :eori, :account_number

      attributes :zip, :zip_address, :bank_country, :bank, :city, :certificates

      attributes :country

      def logo
        image_path( object.logo, "/flags/#{object.country_code.upcase}.svg", "60x60") 
      end

      def country
        {code: object.country_code , title: object.country_title}
      end

      def role
        {id: object.role , title: I18n.t("common.company_info.roles.#{object.role}")}
      end

      def bank_country
        {code: object.bank_country , title: object.country_bank_title}
      end
      def certificates
        ActiveModelSerializers::SerializableResource.new(
          object.presenter.certificates,
          each_serializer: Meat::CertificateSerializer::Short
        )
      end
    end

    class Info < Short
      DEFAULT = "/avatar_big.png"


      attributes :info, :pasport_verified, :bill_verified, :certificates, :bill_on_review, :passport_on_review, :blured

      def blured
        @instance_options[:blur_info].presence
      end

      def check_blur_info(text)
        @instance_options[:blur_info].presence ?  Digest::MD5.hexdigest(text.to_s) : text
      end

      def bill_on_review
        object.presenter.bill_on_review
      end

      def passport_on_review
        object.presenter.passport_on_review
      end


      def certificates
        ActiveModelSerializers::SerializableResource.new(
          object.presenter.certificates,
          each_serializer: Meat::CertificateSerializer::Short
        )
      end
      def logo
        image_path( nil, "/flags/#{object.country_code.upcase}.svg", "60x60") 
      end
      def info
        infos = [
          {title: I18n.t("common.company_info.role"), value: I18n.t("common.company_info.roles.#{object.role}") }
        ]
        infos << {title: I18n.t("common.company_info.country"), value: check_blur_info(object.country_title)} if object.country_code
        infos =[]
        if @instance_options[:current_user].presence && @instance_options[:current_user].company_id == @object.id
          infos << {title: I18n.t("common.company_info.address"), value: check_blur_info( object.address ) } if object.address.presence
          infos << {title: I18n.t("common.company_info.about"), value: check_blur_info( object.about ) } if object.about.presence

          infos << {title: I18n.t("common.company_info.total_emploees"), value: check_blur_info( object.total_emploees.to_s )} if object.total_emploees.presence
          infos << {title: I18n.t("common.company_info.year_establishment"), value: check_blur_info( object.year_establishment.to_s )} if object.year_establishment.presence
          infos << {title: I18n.t("common.company_info.success_deal"), value: check_blur_info( object.success_deal.to_s )} unless object.success_deal.zero?
          infos << {title: I18n.t("common.company_info.plant_number"), value: check_blur_info( object.plant_number )} if object.plant_number.presence
        end

        infos
      end

    end

    class Rating < Short
      attributes :rating, :rating_code, :points_left, :next_status, :ratings

      def points_left
        object.presenter.points_left
      end

      def next_status
        object.presenter.next_status
      end

      def ratings
        object.rating_extended.inject([]) do |arr,(k,v)|
          arr << {
            title: I18n.t("common.ratings.#{k}"),
            value: v
          }
        end
      end
    end

    class Charts < ActiveModel::Serializer
      include Chartable
    end

    class Contacts < BeOneAdmin::Serializer
      attributes :id,:logo, :title, :rating_code, :role, :info, :r_id, :on_map
      DEFAULT = "/avatar.png"
      def logo
        image_path( object.logo, "/flags/#{object.country_code.upcase}.svg", "60x60") 
      end

      def title 
        I18n.t("common.company_title", title: @object.title, id: @object.id ).html_safe
      end
      def r_id
        object.managers.find_by(is_company_owner:true).id
      end
      def info
        infos = [
          {title: I18n.t("common.company_info.role"), value: I18n.t("common.company_info.roles.#{object.role}") }
        ]
        infos << {title: I18n.t("common.company_info.email"), value: object.managers.first.email} 
        infos << {title: I18n.t("common.company_info.phone"), value: object.managers.first.phone} 
        infos << {title: I18n.t("common.company_info.representative"), value: object.representative.presence || object.managers.first.presenter.user_name}
        infos << {title: I18n.t("common.company_info.country"), value: object.country_title} if object.country_code
        infos << {title: I18n.t("common.company_info.address"), value: object.address} if object.address.presence
        infos << {title: I18n.t("common.company_info.about"), value: object.about} if object.about.presence

        infos << {title: I18n.t("common.company_info.total_emploees"), value: object.total_emploees} if object.total_emploees.presence
        infos << {title: I18n.t("common.company_info.year_establishment"), value: object.year_establishment} if object.year_establishment.presence
        infos << {title: I18n.t("common.company_info.success_deal"), value: object.success_deal} unless object.success_deal.zero?
        infos << {title: I18n.t("common.company_info.plant_number"), value: object.plant_number} if object.plant_number.presence

        infos

      end


    end

  end
end


