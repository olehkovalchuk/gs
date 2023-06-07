module Meat
  module RequestSerializer

    class Short < BeOneAdmin::Serializer
      attributes :id, :title, :price, :delivery, :tooltip, :type, :active, :in_top

      def price
        object.presenter.price_formated(@instance_options[:current_user].presence)
      end

      def delivery
        object.presenter.delivery_formated
      end

      def title
        object.category_title
      end

      def in_top
        object.in_top && object.in_top_expire_at && object.in_top_expire_at >= Date.current
      end

      def tooltip
        object.delivery_conditions.any? ? [ "#{I18n.t('common.all_incoterms')}:", object.presenter.delivery_conditions.join("<br>").html_safe ].join("<br>").html_safe : ""
      end

      def type
        :request
      end

      def can_bid
        true #@instance_options[:current_user] && object.company_id != @instance_options[:current_user].company_id
      end

      def can_send_offer
        true#@instance_options[:current_user] && object.company_id != @instance_options[:current_user].company_id
      end

      attributes :r_id

      def r_id
        object.company_user_id
      end
    end

    class FrontList < Short
      attributes :company, :bid, :info

      def company
        Meat::CompanySerializer::Short.new(object.company, current_user: @instance_options[:current_user] )
      end

      def bid
        object.bids.count.zero? ? {} : Meat::BidSerializer::Main.new(object.bids.last,blur_info: @instance_options[:current_user].nil?, current_user: @instance_options[:current_user])
      end

      def info
        arr = []
        arr << { title: I18n.t("common.offer_info_short.payment_terms"), value: object.presenter.payment_types } if object.payment_types.any?
        arr << { title: I18n.t("common.offer_info_short.permissions"), value: object.presenter.permissions_to.join(",") } if object.permissions_to.any?
        # arr << { title: I18n.t("common.offer_info_short.payment_terms"), value: object.presenter.permissions_to } if object.permissions_to.any?
        arr << { title: I18n.t("common.offer_info_short.quantity"), value: "#{object.quantity} T" } if object.quantity > 0
        arr << { title: I18n.t("common.offer_info_short.documents"), value: object.presenter.documents.join(",") } if object.documents.any?
        arr
      end

    end
    class Item < FrontList
      attributes :bids, :recomendations, :description, :certificates, :blured
      attributes :permission_title, :origin_title, :b_id

      def b_id
        object.price_from.to_f
      end

      def origin_title
        object.presenter.origins
      end

      def permission_title
        ''
      end

      def blured
        @instance_options[:blur_info].presence
      end

      def check_blur_info(text)
        text
      end

      def description
        check_blur_info(object.description)
      end

      def company
        Meat::CompanySerializer::Info.new(object.company, blur_info: @instance_options[:blur_info], current_user: @instance_options[:current_user])
      end

      def bids
        ActiveModelSerializers::SerializableResource.new(
          object.bids,
          each_serializer: Meat::BidSerializer::Main,
          current_user: @instance_options[:current_user],
          blur_info: @instance_options[:blur_info]
        )
      end

      def info
        common = []
        common << { title: I18n.t("common.offer_info_short.payment_terms"), value: check_blur_info( object.presenter.payment_types) } if object.payment_types.any?
        common << { title: I18n.t("common.offer_info_short.permissions"), value: check_blur_info( object.presenter.permissions_to.join(",")) } if object.permissions_to.any?
        common << { title: I18n.t("common.offer_info_short.quantity"), value: check_blur_info("#{object.quantity} T") }
        common << { title: I18n.t("common.offer_info_short.documents"), value: check_blur_info(object.presenter.documents.join(",")) } if object.documents.any?

        infos = [
          { title: I18n.t("common.offer_info_short.info_title"), data: common }
        ]
        infos
      end
      def recomendations
        ActiveModelSerializers::SerializableResource.new(
          object.presenter.recomendations,
          each_serializer: Meat::RequestSerializer::Short,
          current_user: @instance_options[:current_user]
        )
      end

      def certificates
        ActiveModelSerializers::SerializableResource.new(
          object.presenter.certificates,
          each_serializer: Meat::CertificateSerializer::Short
        )
      end

    end

    class Cabinet < BeOneAdmin::Serializer

      attributes :id, :price_from, :price_to, :description, :category, :quantity, :certificates

      attributes :delivery_conditions, :origins, :permissions_to, :payment_types, :documents, :active, :market

      def origins
        Geo::Country.where(code: object.origins ).map{ |c| {code: c.code, title: c.title} }
      end


      def payment_types
        Delivery::PaymentType.where(id: object.payment_types ).map{ |c| {id: c.id, title: c.title} }
      end

      def certificates
        Meat::Certificate.where(id: object.certificates ).map{ |c| {id: c.id, title: c.title} }
      end

      def delivery_conditions
        Delivery::Condition.where(code: object.delivery_conditions ).map{ |c| {id: c.code, title: c.code} }
      end

      def documents
        Meat::Document.where(id: object.documents ).map{ |c| {id: c.id, title: c.title} }
      end


      def price_from
        {
          input: object.price_from,
          select: object.currency
        }
      end

      def price_to
        {
          input: object.price_from,
          select: object.currency
        }
      end

      def category
        {
          id: object.category_id,
          title: object.category_title
        }
      end

      def market
        {
          id: object.market,
          title: I18n.t("common.marketplaces.#{object.market}")
        }
      end
    end
  end
end
