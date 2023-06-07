class ProcesesController < ApplicationController

  before_action :require_login

  before_action :require_membership, only: [:create, :start]


  def index
    process_and_respond!(operation: Order::ProcesOperation::FrontList.new( with_default_params( filter: params[:filter], page: (params[:page].presence || 1) ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Order::ProcesSerializer::List,
          current_user: current_user
        )
      }
    end
  end

  def start
    process_and_respond!(operation: Meat::OfferOperation::ReadWithAuth.new( with_default_params( id: params[:id], kibana_log: 'start_process' ) ) ) do |operation, result|
      render json: {success: true, item: Meat::OfferSerializer::FullForProcess.new(result,current_user: current_user) }
    end
  end

  def show
    process_and_respond!(operation: Order::ProcesOperation::ReadWithAuth.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, item: Order::ProcesSerializer::Item.new(result,current_user: current_user) }
    end
  end

  def sign
    process_and_respond!(operation: Order::ProcesOperation::Sign.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.process_id }
    end
  end

  def upload
    process_and_respond!(operation: Order::ProcesOperation::Upload.new( with_default_params( upload_params.merge(id: params[:id]) ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.process_id }
    end
  end

  def add_file
    process_and_respond!(operation: Order::ProcesOperation::AddFile.new( with_default_params( upload_params.merge(id: params[:id]) ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.process_id }
    end
  end

  def download
    process_and_respond!(operation: Order::ProcesOperation::Download.new( with_default_params( id: params[:id], doc_id: params[:doc_id] ) ), with_redirect_back: true ) do |operation, result|
      redirect_to url_for( result )
    end
  end

  def create
    process_and_respond!(operation: Order::ProcesOperation::Create.new( with_default_params( process_params ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.process_id }
    end
  end

  def destroy
    process_and_respond!(operation: Order::ProcesOperation::Cancel.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.process_id }
    end
  end

  def complain
    process_and_respond!(operation: Order::ProcesOperation::Complain.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.process_id }
    end
  end

  def update
    process_and_respond!(operation: Order::ProcesOperation::Update.new( with_default_params( process_params ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.process_id }
    end
  end

  def show_step
    process_and_respond!(operation: Order::ProcesOperation::ShowStep.new( with_default_params( id: params[:id], step: params[:step] ) ) ) do |operation, result|
      render json: {success: true, item: Order::ProcesSerializer::Step.new(result,current_user: current_user) }
    end
  end

  def complete_step
    process_and_respond!(operation: Order::ProcesOperation::CompleteStep.new( with_default_params( params.permit(fields:{}).merge( id: params[:id], step: params[:step]) ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.process_id }
    end
  end

  private

  def process_params
    _params = params.permit(:id,:is_safe,:draft,:product_id,:title,:quantity,:comment,:price,:currency,:origin,:month_of_production,:delivery_code,:payment_type_id,:pre_pay,:post_pay,:shiping_line,:destination_port,:packing,documents:{}, company:[:title,:zip_address,:phone,:phone_number,:account_number,:country_code,:address],additional_contact_person:[:first_name,:last_name,:phone,:phone_number,:position,:country_code,:email],files:{})
    _params[:documents] = (_params[:documents] || {}).values
    _params
  end
  def upload_params
    params.permit( files:{} )
  end
end
