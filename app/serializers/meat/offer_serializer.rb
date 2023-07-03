# == Schema Information
#
# Table name: meat_offers
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(FALSE)
#  certificates        :integer          default([]), is an Array
#  currency            :string
#  deleted             :boolean          default(FALSE)
#  delivery_conditions :string           default([]), is an Array
#  delivery_country    :string
#  delivery_port       :string
#  delivery_type       :string
#  description         :text
#  documents           :integer          default([]), is an Array
#  in_top              :boolean          default(FALSE)
#  in_top_expire_at    :date
#  length_from         :float
#  length_to           :float
#  length_type         :string(2)
#  market              :string           default("meat"), not null
#  origin              :string(2)        not null
#  package_type        :string           default("fixed"), not null
#  packages            :integer          default([]), is an Array
#  payment_types       :string           default([]), is an Array
#  permissions_to      :jsonb            not null
#  plain_permissions   :jsonb            not null
#  plant_number        :string
#  price_from          :float            default(0.0), not null
#  price_to            :float            default(0.0), not null
#  price_type          :string           default("MT")
#  quantity            :float            not null
#  quantity_type       :string           default("T"), not null
#  week_from           :integer
#  week_to             :integer
#  weight_from         :float
#  weight_to           :float
#  weight_type         :string(2)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  category_id         :integer          not null
#  company_id          :integer          not null
#  company_user_id     :integer          not null
#
module Meat
  module OfferSerializer

    class Mini < BeOneAdmin::Serializer
      attributes :id, :title, :img, :price, :type, :quantity
      def price
        object.presenter.price_formated(@instance_options[:current_user].presence)
      end
      def img
        image_path(object.images.first, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
      end

      def title
        object.category_title
      end

      def type
        :offer
      end


    end

    class Short < BeOneAdmin::Serializer
      attributes :id, :title, :img, :price, :delivery, :tooltip, :type, :can_bid, :verified, :hot, :active, :in_top

      def price
        object.presenter.price_formated(@instance_options[:current_user].presence)
      end

      def hot
        (object.created_at + 2.days).end_of_day > Time.zone.now
      end

      def in_top
        object.in_top && object.in_top_expire_at && object.in_top_expire_at >= Date.current
      end

      def verified
        object.company.pasport_verified
      end

      def delivery
        object.presenter.delivery_formated
      end

      def img
        image_path(object.images.first, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
      end

      def title
        object.category_title
      end

      def can_bid
        true #@instance_options[:current_user] && object.company_id != @instance_options[:current_user].company_id
      end

      def tooltip
        object.delivery_conditions.any? ? [ "#{I18n.t('common.all_incoterms')}:", object.presenter.delivery_conditions.join("<br>").html_safe ].join("<br>").html_safe : ""
      end
      def type
        :offer
      end


      attributes :r_id

      def r_id
        object.company_user_id
      end

    end

    class FrontList < Short
      attributes :company, :bid, :info

      def img
        logo = object.images.first
        if logo.kind_of?(ActiveStorage::Attachment) || logo&.attached?
          logo.variant(resize_to_fit: [326, 326]).processed.service_url rescue  image_path(logo)
        else
          ActionController::Base.helpers.image_url("product-m.png")
        end
      end

      def company
        Meat::CompanySerializer::Short.new(object.company, current_user: @instance_options[:current_user])
      end

      def bid
        object.bids.count.zero? ? {} : Meat::BidSerializer::Main.new(object.bids.last,blur_info: @instance_options[:current_user].nil?, current_user: @instance_options[:current_user])
      end

      def info
        arr = []
        arr << { title: I18n.t("common.offer_info_short.payment_terms"), value: object.presenter.payment_types } if object.payment_types.any?
        arr << { title: I18n.t("common.offer_info_short.origin_title"), value: object.origin_country_title }
        arr << { title: I18n.t("common.offer_info_short.permissions"), value: object.presenter.permissions_to.join(", ") } if object.permissions_to.any?
        arr << { title: I18n.t("common.offer_info_short.quantity"), value: "#{object.quantity} T" } unless object.quantity.zero?
        arr
      end
    end

    class Item < FrontList


      attributes :bids, :recomendations, :images, :certificates, :description, :blured, :b_id
      attributes :permission_title, :origin_title, 

      def b_id
        object.price_from.to_f
      end

      def permission_title
        object.presenter.permissions_to.join(",") 
      end

      def origin_title
        object.origin_country_title
      end

      def check_blur_info(text)
        text
      end

      def blured
        @instance_options[:blur_info].presence
      end

      def description
        check_blur_info(object.description)
      end

      def info
        infos = []
        common = [
          { title: I18n.t("common.offer_info_short.origin_title"), value: check_blur_info( object.origin_country_title ) },
        ]
        common << { title: I18n.t("common.offer_info_short.permissions"), value: check_blur_info( object.presenter.permissions_to.join(",") ) } if object.permissions_to.any?
        common << { title: I18n.t("common.offer_info_short.port"), value: check_blur_info( object.port_title ) } if object.port.presence


        shipping = [
          { title: I18n.t("common.offer_info_short.payment_terms"), value: check_blur_info( object.presenter.payment_types) },
          { title: I18n.t("common.offer_info_short.delivery_conditions"), value: check_blur_info( object.delivery_conditions.join(",") ) },
        ]
        shipping << { title: I18n.t("common.offer_info_short.documents"), value: check_blur_info( object.presenter.documents.join(",") ) } if object.documents.any?

        packing = []
        packing << { title: I18n.t("common.offer_info_short.quantity"), value: check_blur_info( "#{object.quantity} T" ) } unless object.quantity.zero?
        packing << { title: I18n.t("common.offer_info_short.package_type"), value: check_blur_info( object.presenter.packages.join(",") ) } if object.packages.any?

        weight = [object.weight_from,object.weight_to].reject{|k| k.to_i.zero? }
        length = [object.length_from,object.length_to].reject{|k| k.to_i.zero? }

        packing << { title: I18n.t("common.offer_info_short.weight"), value: check_blur_info( "#{weight.join(" - ")} #{object.weight_type}" ) } if weight.any?
        packing << { title: I18n.t("common.offer_info_short.length"), value: check_blur_info( "#{length.join(" - ")} #{object.length_type}" ) } if length.any?

        infos = [
          { title: I18n.t("common.offer_info_short.info_title"), data: common },
          { title: I18n.t("common.offer_info_short.shipping_title"), data: shipping },
          { title: I18n.t("common.offer_info_short.packing_title"), data: packing }
        ]

        # infos << { title: I18n.t("common.offer_info_short.about"), data: [{ title: '', value: object.description }] } if object.description.presence

        infos

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

      def recomendations
        ActiveModelSerializers::SerializableResource.new(
          object.presenter.recomendations,
          each_serializer: Meat::OfferSerializer::Short,
          current_user: @instance_options[:current_user]
        )
      end

      def images
        if object.images.any?
          object.images.map do |i|
            image_path(i, ActionController::Base.helpers.image_url("product.png"), "487x487")
          end
        else
          [image_path(object.images.first, ActionController::Base.helpers.image_url("product.png"), "487x487")]
        end

      end

      def certificates
        ActiveModelSerializers::SerializableResource.new(
          object.presenter.certificates,
          each_serializer: Meat::CertificateSerializer::Short
        )
      end
    end

    class Cabinet < BeOneAdmin::Serializer
      attributes :plant_number, :weight_from, :weight_to, :quantity, :length_from, :length_to, :category, :weight_type, :length_type
      attributes :certificates, :documents, :payment_types, :permissions_to, :delivery_conditions, :packages
      attributes :origin, :description
      attributes :week_from, :week_to, :images, :price_from, :price_to, :delivery_port, :id, :active, :market

      def images
        object.images.inject({}) do |hash,i|
          hash[i.id] = image_path(i, ActionController::Base.helpers.image_url("product-s.png"), "80x80")
          hash
        end
      end

      def origin
        {
          code: object.origin,
          title: object.origin_country_title,
        }
      end

      def delivery_port
        object.port ? {code: object.delivery_port, title: object.port_title } : {}
      end

      def certificates
        Meat::Certificate.where(id: object.certificates ).map{ |c| {id: c.id, title: c.title} }
      end

      def delivery_conditions
        Delivery::Condition.where(code: object.delivery_conditions ).map{ |c| {id: c.code, title: c.code, need_seller_port: c.need_seller_port, need_seller_country: c.need_seller_country} }
      end

      def documents
        Meat::Document.where(id: object.documents ).map{ |c| {id: c.id, title: c.title} }
      end

      def payment_types
        object.presenter.payment_type_objects.map{ |c| {id: c.id, title: c.title} }
      end

      def packages
        Delivery::Package.where(id: object.packages ).map{ |c| {id: c.id, title: c.title} }
      end

      def price_from
        {
          input: object.price_from,
          select: object.currency
        }
      end

      def price_to
        {
          input: object.price_to,
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

    class FullForProcess < BeOneAdmin::Serializer

      attributes :recepinet, :current_user, :offer, :payment_type, :delivery, :stage,  :documents, :packing
      attributes :quantity, :product_id, :title, :origin, :currency, :price , :buyer_step
      attributes :recepient_company, :current_company, :company_details, :is_safe

      def is_safe
        false
      end

      def recepinet
        Meat::CompanyUserSerializer::Edit.new(object.company_user)
      end

      def current_user
        Meat::CompanyUserSerializer::Edit.new(@instance_options[:current_user])
      end

      def offer
        Meat::OfferSerializer::Mini.new(object,current_user:@instance_options[:current_user])
      end

      def payment_type
        {id: object.presenter.payment_type.id, title: object.presenter.payment_type.title, has_prepay: object.presenter.payment_type.has_prepay}
      end

      def packing
        {id: object.presenter.packing.id, title: object.presenter.packing.title}
      end

      def delivery
        {id: object.presenter.delivery.code, title: object.presenter.delivery.code, need_seller_port: object.presenter.delivery.need_seller_port, need_sea_line: object.presenter.delivery.need_sea_line }
      end

      def product_id
        object.id
      end

      def currency
        object.currency
      end

      def price
        object.presenter.avg_price
      end

      def title
        object.category_title
      end

      def origin
        {
          code: object.origin,
          title: object.origin_country_title,
        }
      end

      def created_at
        object.created_at.strftime("%d %b %Y")
      end

      def quantity
        object.quantity.zero? ? "" : object.quantity
      end

      def stage
        1
      end

      def buyer_step
        true
      end

      def documents
        []
      end

      def recepient_company
        Meat::CompanySerializer::Po.new(  object.company, current_user: @instance_options[:current_user] )
      end

      def company_details
        Meat::CompanySerializer::Po.new(  @instance_options[:current_user].company, current_user: @instance_options[:current_user] )
      end

      def current_company
        Meat::CompanySerializer::Po.new(@instance_options[:current_user].company, current_user: @instance_options[:current_user])
      end

    end
  end
end



