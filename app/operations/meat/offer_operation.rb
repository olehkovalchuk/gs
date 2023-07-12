
module Meat
  module OfferOperation
    class Base
      include Operation::Base
      crudify do
        model_name Offer
      end
    end

    class ReadWithAuth < Read
      def perform
        add_error!(:session_expired) unless form.current_user
        add_error!(:cant_order_own_offer, "Cant order own products") if form.current_user.company_id == @model.company_id
        ::KibanaLogger.push(form.kibana_log, @model.presenter.kibana_data) if form.kibana_log
        return @model
      end
    end


    class MoveToTop < Read
      validate_with Meat::OfferValidation::ReadWithAuth
      def perform
        add_error!(:session_expired) unless form.current_user
        add_error!(:not_permited, "Not permitted") if form.current_user.company_id != @model.company_id

        add_error!(:not_allowed, 'You have reached your maximum Showcase quantity. Update your membership to get more!') unless form.current_user.presenter.allowed_to_use?(:top_offers)

        ::KibanaLogger.push("to_top", @model.presenter.kibana_data )
        Meat::CompanyAction.update_limits(@model.company, :top_offers)

        @model.update_attributes(in_top: true, in_top_expire_at: Date.current + 7.days)
        true
      end
    end


    class SendToPromote < Read
      validate_with Meat::OfferValidation::SendToPromote
      def perform

        form.current_user.company.offers.where(id: form.ids).each do |item|
          ::KibanaLogger.push("promote", item.presenter.kibana_data )
          ::Meat::Promotion.create!( promo_type: form.promo_type, promotable_id: item.id, promotable_type: 'Meat::Offer', company_id: item.company_id, company_user_id: form.current_user.id )
        end
        true
      end
    end

    class RemoveAttach < ReadWithAuth
      def perform
        add_error!(:cant_delete_this_image, "Cant delete this image") unless form.current_user.company_id == @model.company_id
        @model.send(form.attach_type).find(form.attach_id).purge
        return @model
      end
    end

    class DestroyWithAuth < Read 
      def perform 
        add_error!(:cant_delete_this_bid, "Cant delete this offer") unless form.current_user.company_id == @model.company_id
        with_transaction do
          old_model = model.dup
          add_error!(:undeletable, "Model cant be deleted") if model.respond_to?(:undeletable) && model.undeletable
          trigger :before_destroy, model
          begin
            result = model.respond_to?(:deleted) ? model.update(deleted: true) : model.destroy!
          rescue ActiveRecord::RecordNotDestroyed => e
            add_error!(:cant_destroy,"Cant be destoyed")
          end

          trigger :after_destroy, old_model

          result
        end
      end
    end

    class Show < Base 
      validate_with Meat::OfferValidation::Read
      def perform
        add_error(:not_found, I18n.t("common.not_found") ) unless @model = Meat::Offer.find_by(id: form.id)
        ::KibanaLogger.push("show_offer", @model.presenter.kibana_data)
        @model
      end
    end

    class FrontList
      include Operation::Base
      LIMIT = 10

      validate_with Meat::OfferValidation::FrontList

      def perform
        # add_error!(:restricted, "Access denided") if form.current_user.nil? && form.page > 1

        relation = form.skip_limit ? Meat::Offer : Meat::Offer.page(form.page).per(LIMIT)
        relation = relation.active.includes(:company,bids:[:sender_company]).with_attached_images
        relation = relation.where(price_from: form.filters.prices[0]..form.filters.prices[1]) if form.filters && form.filters.prices.count == 2
        relation = relation.where(market: form.market)

        ::KibanaLogger.push("show_offers",{
          category_id: form.filters.try(:category_id).to_i,
        })

        unless form.company_id.zero?
          relation = relation.where(company_id: form.company_id )
        end
        if form.filters
          unless form.filters.id.zero?
            relation = relation.where(category_id: Meat::Category.find(form.filters.id).self_and_ancestors_ids ).limit(6)
          end

          unless form.filters.category_id.zero?
            relation = relation.where(category_id: Meat::Category.find(form.filters.category_id).self_and_descendants_ids )
          end

          if form.filters.category_seo.present?
            relation = relation.where(category_id: Meat::Category.find_by(seo_name: form.filters.category_seo).self_and_descendants_ids )
          end

          relation = relation.where(origin: form.filters.origins ) if form.filters.origins.any?

          relation = relation.where(id: form.filters.ids ) if form.filters.ids.any?


          if form.filters.delivery.any?
            relation = relation.where("delivery_conditions::text[] && ARRAY[?]", form.filters.delivery)
          end

          if form.filters.permissions.any?
            permissions = form.filters.permissions.map{|pm| type, code = pm.split("_"); "region" == type ? ::Geo::Region.find_by(code: code).countries.pluck(:code) : code  }.flatten.uniq
            relation = relation.where("plain_permissions ?| ARRAY[:permissions]", permissions: permissions)
          end

          if form.filters.payment_types.any?
            relation = relation.where("payment_types::int[] && ARRAY[:payment_types]", payment_types: form.filters.payment_types.map(&:to_i))
          end

          if form.filters.title.presence
            relation = relation.joins(:category)
            relation = relation.where("description ILIKE :title OR meat_categories.title->>'#{I18n.locale}' ILIKE :title", title: "%#{form.filters.title}%")
          end
        end

        sort = if form.sorting.presence
          if "rating" == form.sorting.field
            relation = relation.joins(:company)
            form.sorting.field = "meat_companies.rating"
          end
          {form.sorting.field => form.sorting.direction}
        else
          {in_top: :desc, updated_at: :desc}
        end

        @model = relation.order(sort).all
        @model.total_pages

      end
    end

    class CabinetList
      include Operation::Base
      validate_with Meat::OfferValidation::CabinetList
      LIMIT = 15
      def perform
        conditions = form.by_company ? {company_id: form.current_user.company_id } : {company_user_id: form.current_user.id }
        relation =  Meat::Offer.page(form.page).per(LIMIT).order(updated_at: :desc).where(conditions)
        relation = relation.where(active: form.filters.active ) if form.filters && !form.filters.active.nil?
        @model = relation.order({updated_at: :desc}).all
        @model.total_pages
      end
    end

    class Bid < Read
      validate_with Meat::OfferValidation::Bid
      def perform
        add_error!(:session_expired) unless form.current_user
        add_error!(:cant_add_own_bid, "Cant BID own products") if form.current_user.company_id == @model.company_id
        ::KibanaLogger.push("bid_offer", @model.presenter.kibana_data)
        Meat::BidOperation::Create.new(
          currency: form.currency,
          amount: form.amount,
          comment: form.comment,
          bidable_type: @model.class.name,
          bidable_id: @model.id,
          sender_company_id: form.current_user.company_id,
          sender_company_user_id: form.current_user.id,
          recipient_company_id: @model.company_id,
          recipient_company_user_id: @model.company_user_id,
          current_user: form.current_user,
        ).process
      end
    end

    class Inquiry < Read
      validate_with Meat::OfferValidation::Inquiry
      def perform
        add_error!(:cant_add_own_bid, "Cant Inquiry own products") if form.current_user && form.current_user.company_id == @model.company_id

        unless form.current_user 
          user = Meat::CompanyUser.find_by(email: form.sender_email )
          unless user
            password = ::BeOneCore::Password.random
            user = Meat::CompanyUserOperation::SignUp.new(
              agree: true,
              email: form.sender_email,
              password: password,
              password_confirmation: password,
              first_name: form.title,
              last_name: form.title,
              role: 'trader',
              company_name: form.title,
              country_code: form.country_code,
              phone_number: form.phone_number,
              phone: form.phone,
              ip: form.ip,
              referer: form.referer,
              user_agent: form.user_agent,
              skip_captcha: true,
              reset_password_token: ::BeOneCore::Password.salt
            ).run
          end
          form.current_user = user.presenter
        end
        add_error!(:not_allowed, 'You have reached your limit of inquiries. To get more limmits, upgrade your membership') unless form.current_user.allowed_to_use?(:sended_inquries)

        RequestStore.store[:kibana_data].merge!(
          current_email: form.current_user.try(:email),
          current_company: form.current_user.try(:company).try(:title)
        )

        inqury = Chat::InquiryOperation::Create.new(
          sender_email: form.sender_email,
          receiver_email: @model.company_user.email,
          title: form.title,
          message: form.message,
          inquirieable_type: @model.class.name,
          inquirieable_id: @model.id,
          sender_company_id: form.current_user&.company_id,
          sender_company_user_id: form.current_user&.id,
          recipient_company_id: @model.company_id,
          recipient_company_user_id: @model.company_user_id,
          current_user: form.current_user,
          country_code: form.country_code,
          phone_number: form.phone_number,
          phone: form.phone,
          post_request: form.post_request,
        ).run

        ::Chat::InquiryOperation::Send.new(id: inqury.id).perform

        kibana_data = @model.presenter.kibana_data.merge(
          current_email: form.current_user.email,
          current_company: form.current_user.company.title,
          sender_company: inqury.sender_company_title,
          sender_company_email: inqury.sender.email,
          recipient_company: inqury.recipient_company_title,
          recipient_company_email: inqury.recipient.email
        )
        ::KibanaLogger.push("inquiry_offer", kibana_data)

        Meat::CompanyAction.update_limits(form.current_user.company, :sended_inquries)
      end
    end


    class Add < Base
      def perform
        add_error!(:not_allowed, 'You have reached your limit of offers. To get more limmits, upgrade your membership') unless form.current_user.presenter.allowed_to_use?(:offers_count)

        operation = Create.new(form.attributes)
        operation.errors.each_pair{|k,v| pp k; add_error!(k,v)} unless operation.process
        Meat::CompanyAction.update_limits(form.current_user.company, :offers_count)

        ::KibanaLogger.push("add_offer", operation.model.presenter.kibana_data)
        true
      end
    end

    class Renew < Base
      def perform
        operation = Update.new(form.attributes)
        operation.errors.each_pair{|k,v| pp k; add_error!(k,v)} unless operation.process
        true
      end
    end


  end
end

