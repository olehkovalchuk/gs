
module Meat
  module OfferAction
    extend self

    def after_create( model, form )
      model.company.increment!(:offers_count)
      model.company_user.increment!(:offers_count)
    end
    def after_destroy( model )
      model.company.decrement!(:offers_count)
      model.company_user.decrement!(:offers_count)
      check_categories(model)
    end

    def after_save( model, form )
      check_categories(model)
    end

    def before_save(model, form)
      model.plain_permissions = form.permissions_to.map{|pm| type, code = pm.split("_"); "region" == type ? ::Geo::Region.find_by(code: code).countries.pluck(:code) : code  }.flatten.uniq.compact
    end


    private

    def check_categories model
      Meat::Category.update_all(active_for_offers: false)
      categories = Meat::Category.where(id: Meat::Offer.active.pluck(:category_id).uniq )
      categories.each do |cat|
        Meat::Category.where(id: cat.self_and_ancestors_ids ).update_all(active_for_offers: true)
      end

      Delivery::PaymentType.update_all(active_for_offers: false)
      Delivery::PaymentType.where(id: Meat::Offer.active.pluck(:payment_types).flatten.uniq ).update_all(active_for_offers: true)
      # Delivery::Permission.update_all(active_for_offers: false)
      # Delivery::Permission.where(id: Meat::Offer.active.pluck(:category_id).uniq ).update_all(active_for_offers: true)
      Delivery::Condition.update_all(active_for_offers: false)
      Delivery::Condition.where(code: Meat::Offer.active.pluck(:delivery_conditions).flatten.uniq ).update_all(active_for_offers: true)

      Geo::Country.update_all(active_offers_origin: false)
      Geo::Country.update_all(active_offers_permission: false)
      Geo::Country.where(id: Meat::Offer.active.pluck(:plain_permissions).flatten.uniq ).update_all(active_offers_permission: true)
      Geo::Country.where(id: Meat::Offer.active.pluck(:origin).uniq ).update_all(active_offers_origin: true)

      Meat::Price.find_or_initialize_by(key: "offers").update!(value: [ Meat::Offer.maximum('price_from'), Meat::Offer.maximum('price_to')] )

      category_ids = model.company.offers.active.pluck(:category_id).concat(model.company.requests.active.pluck(:category_id)).uniq

      category_ids = Meat::Category.where(id: category_ids).includes(parent:[:parent]).inject([]) do |arr,cat|
        arr << (cat.parent_id.to_i.zero? ? cat.id : (  cat.parent.parent_id.to_i.zero? ?  cat.parent_id : cat.parent.parent_id  ))
        arr
      end.uniq

      model.company.update(category_ids: category_ids )

    end


    # Available callbacks methods
    # after_save
    # before_save
    # after_create
    # before_create
    # after_destroy
    # before_destroy
    # after_update
    # before_update
  end
end



