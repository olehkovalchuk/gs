module Meat
  module BidSerializer
    class Main < BeOneAdmin::Serializer
      attributes :currency,:amount, :comment, :company, :created_at

      def company
        Meat::CompanySerializer::Short.new(object.sender_company, current_user: @instance_options[:current_user])
      end

      def created_at
        object.created_at.strftime("%d %b %Y")
      end

      def amount
        @instance_options[:blur_info] ? "#{I18n.t("common.only_for_users")} #{object.currency}/MT".html_safe : "#{object.amount} #{object.currency}/MT"
      end

    end

    class List < Main
      attributes  :product, :sender, :type, :link, :id

      def amount
        @instance_options[:blur_info] ? I18n.t("common.only_for_users").html_safe : "#{object.amount} #{object.currency}"
      end

      def link
        {
          name: "#{object.bidable_type.split("::").last.downcase}",
          params: {id: object.bidable_id}
        }
      end

      def product
        {
          title: object.bidable.category_title,
          img: object.bidable.respond_to?(:images) ? image_path(object.bidable.images.first, ActionController::Base.helpers.image_url("product-s.png"), "80x80"): nil
        }
      end

      def type
        @instance_options[:current_user].company_id == self.object.sender_company_id ? I18n.t("common.sended") : I18n.t("common.received")
      end

      def sender
        "#{object.sender.first_name} #{object.sender.first_name}"
      end


    end


  end
end
