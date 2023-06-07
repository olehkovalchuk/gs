module Meat
  class OfferPresenter < BasePresenter
    def price_formated(user, skip_user = false)
      # return "#{I18n.t("common.only_for_users")} #{@object.currency}/#{@object.price_type}".html_safe if !skip_user && !user || !skip_user && !user.verificated_email
      price = [@object.price_from.presence,@object.price_to.presence].reject{|pr| pr.nil? || pr.to_i.zero?}
      price.any? ? "#{price.uniq.sort.join('-')} #{@object.currency}/#{@object.price_type}" : I18n.t('common.rfq_without_price')
    end

    def avg_price
      price = [@object.price_from.presence,@object.price_to.presence].reject{|pr| pr.nil? || pr.to_i.zero?}
      (price.sum / price.count).ceil
    end

    def delivery_formated
      if @object.delivery_conditions.include?("EXW")
        "EXW #{@object.origin_country_title}"
      elsif (fas = self.delivery_conditions_objects.find_by(need_seller_port: true))
        "#{fas.code} #{@object.port ? @object.port_title : ''}"
      else
        @object.delivery_conditions.first
      end
    end

    def recomendations
      @recomendations ||= Meat::Offer.where.not(id:@object.id).active.order(created_at: :desc).limit(3)
    end



    def permissions_to
      permissions = @object.permissions_to.inject({country:[],region:[]}){|hash,s| type,code = s.split("_"); hash[type.to_sym] << code; hash }
      perms = []
      perms.concat(Geo::Region.where(code: permissions[:region] ).map(&:title)) if permissions[:region].any?
      perms.concat(Geo::Country.where(code: permissions[:country] ).map(&:title)) if permissions[:country].any?
      perms#.join(",")
    end

    def certificates
      @certificates ||= Meat::Certificate.where(id: @object.certificates )
    end


    def documents
      documents_objects.map(&:title)
    end
    def documents_objects
      @documents_objects ||= Meat::Document.where(id: @object.documents )
    end

    def payment_types
      payment_type_objects.map(&:title).join(",")
    end

    def payment_type_objects
      @payment_type_objects ||= Delivery::PaymentType.where(id: @object.payment_types )
    end

    def packages
      packages_objects.map(&:title)
    end

    def packing
      packages_objects.first
    end

    def packages_objects
      @packages_objects ||= Delivery::Package.where(id: @object.packages )
    end


    def delivery_conditions_objects
      @delivery_conditions_objects ||= Delivery::Condition.where(code: @object.delivery_conditions )
    end

    def delivery_conditions
      delivery_conditions_objects.map(&:code)
    end

    def delivery
      delivery_conditions_objects.first
    end


    def payment_type
      @payment_type ||= payment_type_objects.first
    end


    def kibana_data
      {
        title: @object.category_title,
        origin: @object.origin_country_title,
        category_id: @object.category_id,
        category_title: @object.category_title,
        delivery: self.delivery.try(:code),
        avg_price: self.avg_price,
        id: @object.id,
        type: 'offer'
      }
    end
  end
end
