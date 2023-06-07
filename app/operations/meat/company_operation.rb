
module Meat
  module CompanyOperation
    class Base
      include Operation::Base
      crudify with:[:exel] do
        model_name Company
      end
    end

    class Chart < Base
      validate_with Meat::CompanyValidation::Chart
      def perform
        form.current_user
      end
    end

    class FrontList < Base
      ::KibanaLogger.push("companies_list",{})
      validate_with Meat::CompanyValidation::FrontList
      def perform
        sort = if form.sorting.presence
          {form.sorting.field => form.sorting.direction}
        else
          {updated_at: :desc}
        end
        relation = Meat::Company.where(on_map: true).where(":market = ANY(markets)", market: form.market)
        if form.filters.presence
          if form.filters.title.presence
            relation = relation.left_outer_joins(offers: :category).left_outer_joins(requests: :category)
            relation = relation.where("
              meat_offers.description ILIKE :title
              OR meat_companies.title ILIKE :title
              OR meat_categories.title->>'#{I18n.locale}' ILIKE :title",
              title: "%#{form.filters.title}%"
            )
          end
        end

        @model = relation.order(sort).distinct.all

      end
    end

    class CalculateRating < Read
      validate_with Meat::CompanyValidation::Read
      def perform
        defaults = {
          authorization: 0,
          activity: 0,
          info: 0,
          offers: 0,
        }
        defaults[:info] += 2 if @model.logo.attached?
        defaults[:info] += 3 if @model.title.presence

        if [@model.address.presence,@model.city.presence,@model.country_code.presence].all?
          defaults[:info] += 5
        elsif 2 == [@model.address.presence,@model.city.presence,@model.country_code.presence].select(&:present?).count
          defaults[:info] += 2
        elsif [@model.address.presence,@model.city.presence,@model.country_code.presence].any?
          defaults[:info] += 1
        end

        if [@model.zip.presence,@model.zip_address.presence].all?
          defaults[:info] += 5
        elsif [@model.zip.presence,@model.zip_address.presence].any?
          defaults[:info] += 2
        end
        if [@model.iban.presence,@model.swift.presence,@model.bank.presence,@model.bank_country.presence].all?
          defaults[:info] += 5
        else
          defaults[:info] += [@model.iban.presence,@model.swift.presence,@model.bank.presence,@model.bank_country.presence].count
        end
        defaults[:info] += 5 if [@model.tic.presence,@model.vat.presence,@model.eori.presence].any?


        defaults[:authorization] += 5 if @model.account_number.presence
        defaults[:authorization] += 5 if @model.bill_verified
        defaults[:authorization] += 5 if @model.pasport_verified
        defaults[:authorization] += 10 unless @model.invoices.approved.count.zero?


        defaults[:offers] += 5 if (@model.offers_count + @model.requests_count) >= 4
        defaults[:offers] += 5 if @model.bids.active.count >= 4
        defaults[:offers] += 3 if @model.created_conversations.count >= 10
        defaults[:offers] += 3 if @model.processes_count >= 5
        defaults[:offers] += 2 if @model.on_map && [@model.latitude && @model.longitude].all?{|l| 0.0 != l}


        defaults[:activity] += 5 if @model.outgoing_offer_views >= 100
        defaults[:activity] += 5 if @model.outgoing_uniq_offer_views >= 100
        defaults[:activity] += 5 if @model.outgoing_offer_views >= 100
        defaults[:activity] += 5 if @model.outgoing_uniq_offer_views >= 100
        defaults[:activity] += 5 if @model.processes_count >= 3


        total_rating = defaults.values.sum
        rating_code = if total_rating >= 81
          :platinum
        elsif total_rating >= 71
          :gold
        elsif total_rating >= 51
          :silver
        else
          :bronze
        end
        @model.update(rating_extended: defaults, rating: total_rating, rating_code: rating_code ) if @model.moderated
        defaults
      end

    end

    class AddMember < Read
      def perform
        ::KibanaLogger.push("add_member_from_cabinet",@model.presenter.kibana_data)


        unless form.skip_limit
          add_error!(:not_allowed, 'You have reached your limit of managers count. To get more limmits, upgrade your membership') unless @model.presenter.allowed_to_use?(:sub_accounts)
        end

        add_error!(:member_limit, "Members overlimit") unless @model.presenter.can_add_member?
        add_error!(:member_exist, "Email taken, please choose another one") if Meat::CompanyUser.exists?(email: form.email )
        password = form.password.presence || (0...8).map { (65 + rand(26)).chr }.join
        code = SecureRandom.hex(10)
        user = Meat::CompanyUser.new(
          company_id: @model.id,
          email: form.email,
          first_name: form.first_name,
          last_name: form.last_name,
          title: form.title.presence || 'Manager',
          password: password,
          phone: form.phone,
          phone_number: form.phone_number,
          country_code: form.country_code,
          is_company_owner: @model.managers_count.zero?,
          verification_codes: [code],
          verificated_email: form.without_mailer,
          reset_password_token: form.reset_password_token
        )
        trigger :after_member_add, @model, form
        if user.save! && !form.without_mailer
          if form.reset_password_token.presence
            user.update_attributes( reset_password_expire_at: Time.zone.now + 1.month, verificated_email: true  )
            UserMailer.inq_registration(user, 'inq_registration').deliver_later
          else
            ::UserMailer.registration(user, form.password, code).send(Rails.env.development? ? :deliver_now : :deliver_later )
          end
        end
        Meat::CompanyAction.update_limits(@model, :sub_accounts, user.is_company_owner)
        user
      end
    end

    class Item  < Read
      include Operation::Base
      validate_with Meat::CompanyValidation::Item
      attr_reader :offers, :requests
      def perform
        ::KibanaLogger.push("add_member_from_cabinet",@model.presenter.kibana_data)
        @offers = Meat::OfferOperation::FrontList.new(company_id: @model[:id], page: form.page).process
        @requests = Meat::RequestOperation::FrontList.new(company_id: @model[:id], page: form.page).process
        @model
      end
    end


    class Members
      LIMIT = 5
      include Operation::Base
      validate_with Meat::CompanyValidation::Members
      def perform
        @model = Meat::CompanyUser.where(company_id: form.current_user.company_id).all
        if form.with_fake
          0.upto(LIMIT).map do |idx|
            @model[idx] || Meat::CompanyUser.new(first_name: "Your", last_name: "Manager #{idx + 1}", title: "Position")
          end
        else
          @model
        end
      end
    end
    class ProductList < Read
      validate_with Meat::CompanyValidation::ProductList
      def perform
        @model.offers.order(updated_at: :desc).map do |o|
          Meat::OfferSerializer::FrontList.new(o, current_user: form.current_user)
        end.concat(
          @model.requests.order(updated_at: :desc).map do |o|
          Meat::RequestSerializer::FrontList.new(o, current_user: form.current_user)
        end
        )
      end
    end

    class ReadForContacts < Read
      validate_with Meat::CompanyValidation::ProductList
      def perform
        add_error!(:not_allowed, 'You have reached your limit of seeing contact details. To get more limmits, upgrade your membership') unless form.current_user.presenter.allowed_to_use?(:show_infos)
        ::KibanaLogger.push("show_contacts", @model.presenter.kibana_data )
        Meat::CompanyAction.update_limits(form.current_user.company, :show_infos)
        @model
      end
    end

    class AddDocuments < Read
      def perform
        ::KibanaLogger.push("add_verification_document",@model.presenter.kibana_data)
        @model.bill.attach(form.bill) if form.bill && !@model.bill_verified
        @model.passport.attach(form.passport) if form.passport && !@model.pasport_verified
        trigger :after_doc_attached, @model, form
        @model
      end
    end

    class DeleteDocument < Read
      def perform
        case form.document
        when "passport"
          @model.passport.purge
          @model.update(pasport_verified: false)
        when "bill"
          @model.passport.purge
          @model.update(bill_verified: false)
        end
        @model
      end
    end


  end
end


