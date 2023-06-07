module Meat
  class RequestPresenter < BasePresenter
    def price_formated(user, skip_user = false)
      # return "#{I18n.t("common.only_for_users")} #{@object.currency}/#{@object.price_type}".html_safe if !skip_user && !user || !skip_user && !user.verificated_email
      price = [@object.price_from.presence,@object.price_to.presence].reject{|pr| pr.nil? || pr.to_i.zero?}
      price.any? ? "#{price.uniq.sort.join('-')} #{@object.currency}/#{@object.price_type}" : I18n.t('common.rfq_without_price')
    end


    def avg_price
      price = [@object.price_from.presence,@object.price_to.presence].reject{|pr| pr.to_i.zero?}
      price.any? ? (price.sum / price.count).ceil : 0
    end

    def delivery_formated
      if @object.delivery_conditions.include?("EXW")
        "EXW #{origins.join(',')}"
      elsif (fas = @object.delivery_conditions & ["FAS","FOB","CFR","CIF"]).any?
        "#{fas[0]}"
      else
        @object.delivery_conditions.first
      end
    end

    def recomendations
      Meat::Request.where.not(id:@object.id).active.order(created_at: :desc).limit(3)
    end

    def origins
      origin_objects.map(&:title)
    end
    def origin_objects
      @origin_objects ||= Geo::Country.where(code: @object.origins)
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


    def certificates
      Meat::Certificate.where(id: @object.certificates )
    end


    def permissions_to
      permissions = @object.permissions_to.inject({country:[],region:[]}){|hash,s| type,code = s.split("_"); hash[type.to_sym] << code; hash }
      perms = []
      perms.concat(Geo::Region.where(code: permissions[:region] ).map(&:title)) if permissions[:region].any?
      perms.concat(Geo::Country.where(code: permissions[:country] ).map(&:title)) if permissions[:country].any?
      perms
    end

    def kibana_data
      {
        title: @object.category_title,
        category_id: @object.category_id,
        category_title: @object.category_title,
        avg_price: self.avg_price,
        id: @object.id,
        type: 'request'
      }
    end

  end
end
