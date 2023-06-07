
module Order
  module PaymentTransactionOperation
    class Base
      include Operation::Base
      crudify with:[:exel] do
        model_name PaymentTransaction
      end
    end

    class FrontList < Base
      LIMIT = 15
      def perform
        conditions = form.current_user.is_company_owner ? {company_id: form.current_user.company_id } : {company_user_id: form.current_user.id }
        @model = Order::PaymentTransaction.page(form.page).per(LIMIT).order(created_at: :desc).where(conditions)
        @model.total_pages
      end
    end

    class Success < Read
      include PayPal::SDK::REST
      def perform
        if @model.token == form.security && @model.system_id == form.paymentId
          if payment = Payment.find(form.paymentId)
            if payment.execute(payer_id: form.PayerID )
              @model.payed!
              package = ::Order::Package.find(@model.item_id)
              trigger :update_company, package, @model
              UserMailer.success_transaction( model.company_user, package ).send(Rails.env.development? ? :deliver_now : :deliver_later )
              return true
            end
          end
        end
        return false
      end
    end

    class Cancelled < Read
      def perform
        @model.cancelled!
        UserMailer.failed_transaction( model.company_user, ::Order::Package.find(@model.item_id) ).send(Rails.env.development? ? :deliver_now : :deliver_later )
      end
    end


    class ForceCreate < Base
      def perform
        add_error!(:service_not_found, "Service not found") unless service = ::Order::Service.find(form.item_id)
        add_error!(:company_not_found, "Company not found") unless company = ::Meat::Company.find(form.company_id)
        @model = ::Order::PaymentTransaction.new(
          item_id: form.item_id,
          status: "payed",
          description: service.title,
          amount: 0,
          currency: "USD",
          item_type: service.code,
          system: form.current_user.email,
          system_id: form.current_user.id,
          token: "Manual",
          company_id: company.id,
          company_user_id: company.managers.first.id,
        )
        @model.save!
        trigger :clear_cache, @model, form
        true
      end
    end

  end
end
