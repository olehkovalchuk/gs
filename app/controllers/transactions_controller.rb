class TransactionsController < ApplicationController
  before_action :require_login
  def index
    process_and_respond!(operation: Order::PaymentTransactionOperation::FrontList.new( with_default_params( page: params[:page] || 1 ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Order::PaymentTransactionSerializer::List
        )
      }
    end
  end

  def success
    process_and_respond!(with_redirect_back: true, operation: Order::PaymentTransactionOperation::Success.new( with_default_params( item_params ) ) ) do |operation, result|
      redirect_to(marketplace_path(anchor: 'cabinet/transactions'), notice: I18n.t("common.payment_success"), flash: { event: 'Purchase', event_data: {value: operation.model.amount, currency: 'USD'} })
    end
  end

  def cancelled
    process_and_respond!(with_redirect_back: true, operation: Order::PaymentTransactionOperation::Cancelled.new( with_default_params( item_params ) ) ) do |operation, result|
      redirect_to root_path, notice: I18n.t("common.payment_cancelled")
    end
  end

  def create
    process_and_respond!(operation: Order::PackageOperation::Pay.new( with_default_params( id: params[:id], discount: ((cookies[:timer].to_i / 1000) > Time.current.to_i) ) ) ) do |operation, result|
      respond_to do |format|
        format.html { redirect_to result }
        format.json { render json: {url: result} }
      end
    end
  end

  def item_params
    params.permit(:id, :paymentId, :token, :PayerID, :security )
  end

end


      # [
      #   { id: '0001',user:{user_name: "test"}, item_type: 'lead-generation', item_text: 'Lead generation', status: 'Destination place', amount: '3690.00', currency: "USD",  created_at: '21/10/019'},
      #   { id: '0001',user:{user_name: "test"}, item_type: 'forward', item_text: 'Lead generation', status: 'Destination place', amount: '3690.00', currency: "USD",  created_at: '21/10/019'},
      #   { id: '0001',user:{user_name: "test"}, item_type: 'promotion', item_text: 'Lead generation', status: 'Destination place', amount: '3690.00', currency: "USD",  created_at: '21/10/019'},
      #   { id: '0001',user:{user_name: "test"}, item_type: 'verification', item_text: 'Lead generation', status: 'Destination place', amount: '3690.00', currency: "USD",  created_at: '21/10/019'},
      #   { id: '0001',user:{user_name: "test"}, item_type: 'logistics', item_text: 'Lead generation', status: 'Destination place', amount: '3690.00', currency: "USD",  created_at: '21/10/019'},
      #   { id: '0001',user:{user_name: "test"}, item_type: 'secure', item_text: 'Lead generation', status: 'Destination place', amount: '3690.00', currency: "USD",  created_at: '21/10/019'},
      # ]


