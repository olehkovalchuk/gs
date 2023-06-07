
module Meat
  module RequestAction
    extend self

    def after_create( model, form )
      model.company.increment!(:requests_count)
      model.company_user.increment!(:requests_count)
      ::SubscriberOperation::Create.( email: model.company_user.email ) if model.subscribe
    end
    def after_destroy( model )
      model.company.decrement!(:requests_count)
      model.company_user.decrement!(:requests_count)
      check_categories(model)
    end

    def after_save( model, form )
      check_categories(model)
    end
    def before_save(model, form)
      model.plain_permissions = form.permissions_to.map{|pm| type, code = pm.split("_"); "region" == type ? ::Geo::Region.find_by(code: code).countries.pluck(:code) : code  }.flatten.uniq.compact
    end

    private

    def check_categories( model )
      Meat::Category.update_all(active_for_requests: false)
      categories = Meat::Category.where(id: Meat::Request.active.pluck(:category_id).uniq )
      categories.each do |cat|
        Meat::Category.where(id: cat.self_and_ancestors_ids ).update_all(active_for_requests: true)
      end

      Delivery::PaymentType.update_all(active_for_requests: false)
      Delivery::PaymentType.where(id: Meat::Request.active.pluck(:payment_types).flatten.uniq ).update_all(active_for_requests: true)
      # Delivery::Permission.update_all(active_for_requests: false)
      # Delivery::Permission.where(id: Meat::Offer.active.pluck(:category_id).uniq ).update_all(active_for_requests: true)
      Delivery::Condition.update_all(active_for_requests: false)
      Delivery::Condition.where(code: Meat::Request.active.pluck(:delivery_conditions).flatten.uniq ).update_all(active_for_requests: true)

      Geo::Country.update_all(active_requests_origin: false)
      Geo::Country.update_all(active_requests_permission: false)
      Geo::Country.where(id: Meat::Request.active.pluck(:plain_permissions).flatten.uniq ).update_all(active_requests_permission: true)
      Geo::Country.where(id: Meat::Request.active.pluck(:origin).uniq ).update_all(active_requests_origin: true)

      Meat::Price.find_or_initialize_by(key: "requests").update!(value: [ Meat::Request.maximum('price_from'), Meat::Request.maximum('price_to')] )




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



