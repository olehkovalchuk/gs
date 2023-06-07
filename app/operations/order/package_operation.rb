OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module Order
  module PackageOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Package
      end
    end
    class Up < Read 
      validate_with Order::PackageValidation::Read
      def perform
        @model.up!
      end
    end

    class Down < Read 
      validate_with Order::PackageValidation::Read
      def perform
        @model.down!
      end
    end

    class Pay < Read
      include PayPal::SDK::REST
      DISCOUNT = 20
      def perform

        service = "paypal"
        description = "#{@model.title} at GlobalSupplies"
        security = SecureRandom.hex(25)
        amount = form.discount ? (@model.price - @model.price * "0.#{DISCOUNT}".to_f) : @model.price
        @transaction = ::Order::PaymentTransactionOperation::Create.new(
          status: :failed,
          description: description,
          amount: amount,
          currency: @model.currency,
          item_type: 'package',
          item_id: @model.id,
          company_id: form.current_user.company_id,
          company_user_id: form.current_user.id,
          system: service,
          token: security
        )

        @transaction.errors.each_pair{|k,v| pp k; add_error!(k,v)} unless @transaction.process

        # ::PayPal::SDK.configure(
        #   mode: "sandbox", # "sandbox" or "live"
        #   client_id: "AR_aZlQ2GO_qwLeSYs34SyEQCVfC6AUUz1pXtWCPD7Jg2bAlW_byTMAons2WRs7WgLvDTjSYirzjLifX",
        #   client_secret: "EKn0w5qI61QcCAx65hxxtvFl6SUT5fucWj51uxQ8XtrVLWNsExE3Mv-mtKJ9XvquNnUoYZbZ3Z0fWyWC",
        #   :ssl_options => { }
        # )
        @payment = Payment.new({
          intent:  "sale",
          payer:  { payment_method:  service },
          redirect_urls: {
            return_url: "#{Rails.application.secrets[:app_protocol]}://#{Rails.application.secrets[:app_host]}/transactions/#{@transaction.model.id}/success?security=#{security}",
            cancel_url: "#{Rails.application.secrets[:app_protocol]}://#{Rails.application.secrets[:app_host]}/marketplace",
          },
          transactions:  [{
            item_list: {
              items: [{
                name: @model.title,
                sku: @model.id,
                price: amount,
                currency: @model.currency,
                quantity: 1
              }]
            },
            amount:  {
              total:  amount,
              currency:  @model.currency
            },
            description:  description
          }]
        })

        if @payment.create
          @redirect_url = @payment.links.find{|v| v.rel == "approval_url" }.href
          Rails.logger.info "Payment[#{@payment.id}]"
          Rails.logger.info "Redirect: #{@redirect_url}"
          operation = ::Order::PaymentTransactionOperation::Update.new( id: @transaction.model.id, system_id: @payment.id, status: :created )
          operation.errors.each_pair{|k,v| pp k; add_error!(k,v)} unless operation.process
        else
          add_error(:payment_creation_failed, "Failed to create payment at #{service}")
          Rails.logger.error @payment.error.inspect
        end

        pp @payment
        @redirect_url
      end
    end


  end
end

