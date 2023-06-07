class MarketplaceOperation
  include Operation::Base
  validate_with MarketplaceValidation
  def perform
    Rails.cache.fetch("gs__key_#{Date.current.strftime('%F')}_#{form.market}", expire_in: 1.day) do
      data ={
        offers:{
          categories: Meat::Category.where(market: form.market).active_for_offers.parents.order(position: :asc).map{|d| d.as_hash(:active_for_offers)},#,
          filters:{
            permissions: Geo::RegionOperation::FilterTree.new(active_type: 'active_for_offers').process,
            origins: Geo::Country.order(code: :asc).all.map{|c| {code:c.code,title:c.title.to_s}},
            payment_types: Delivery::PaymentType.active_for_offers.map{|c| {code:c.id,title:c.title.to_s}},
            delivery_conditions: Delivery::Condition.active_for_offers.not_for_safe.map{|c| {code:c.code,title:c.code}},
            prices: Meat::Price.where(key: :offer).pluck(:value),
          }

        },
        requests: {
          categories: Meat::Category.where(market: form.market).active_for_requests.parents.order(position: :asc).map{|d| d.as_hash(:active_for_requests)},#,
          filters:{
            permissions: Geo::RegionOperation::FilterTree.new(active_type: 'active_for_requests').process,
            origins: Geo::Country.order(code: :asc).all.map{|c| {code:c.code,title:c.title.to_s}},
            payment_types: Delivery::PaymentType.active_for_requests.map{|c| {code:c.id,title:c.title.to_s}},
            delivery_conditions: Delivery::Condition.active_for_requests.not_for_safe.map{|c| {code:c.code,title:c.code}},
            prices: Meat::Price.where(key: :request).pluck(:value)
          }

        },
        currencies: ['USD', 'EUR'],
        default_currency: 'USD',
        roles: ['seller','buyer','trader'].map{|d| {id: d, title: I18n.t("common.company_info.roles.#{d}")} },
        categories: Meat::Category.active.parents.order(position: :asc).map{|d| d.as_hash(:active)},
        permissions: Geo::RegionOperation::FilterTree.new(active_type: :active).process,
        origins: ActiveModelSerializers::SerializableResource.new(
          Geo::Country.order(title: :asc).all,
          each_serializer: Geo::CountrySerializer::Short
        ),
        ports: ActiveModelSerializers::SerializableResource.new(
          Geo::Port.active.order(code: :asc).all,
          each_serializer: Geo::CountrySerializer::Short
        ),
        payment_types: Delivery::PaymentType.active.all.map{|d| {id: d.id, title: d.title.to_s, has_prepay: d.has_prepay,} },
        delivery_conditions: Delivery::Condition.active.not_for_safe.all.map{|d| {id: d.code, title: d.code, need_seller_port: d.need_seller_port.present?, need_seller_country: d.need_seller_country.present?, need_sea_line: d.need_sea_line.present? } },
        packages: Delivery::Package.active.all.map{|d| {id: d.id, title: d.title.to_s, markets: d.markets} },
        documents: Meat::Document.active_for_offer.all.map{|d| {id: d.id, title: d.title.to_s, markets: d.markets} },
        po_documents: Meat::Document.active_for_po.all.map{|d| {id: d.id, title: d.title.to_s, need_before_sign: d.need_before_sign.present?, need_sign: d.need_sign.present?} },
        certificates: Meat::Certificate.active.all.map{|d| {id: d.id, title: d.title.to_s, markets: d.markets} },
        sea_lines: Geo::SeaLine.active.all.map{|d| {id: d.id, title: d.title.to_s} },
        marketplaces: AVAILABLE_MARKETPLACES,
        default_market: DEFAULT_MARKET
      }
    end
  end
end
