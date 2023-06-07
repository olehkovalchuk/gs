class RequestsController < ApplicationController
  before_action :require_login, except:[:show,:index,:inquiry]

  def bid
    process_and_respond!(operation: Meat::RequestOperation::Bid.new( with_default_params( bid_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def inquiry
    process_and_respond!(operation: Meat::RequestOperation::Inquiry.new( with_default_params( inquiry_params ) ) ) do |operation, result|
      render json: {success: true, message: I18n.t('common.inquiry_saved')}
    end
  end

  def to_top
    process_and_respond!(operation: Meat::RequestOperation::MoveToTop.new( with_default_params( id: params[:id]  ) ) ) do |operation, result|
      render json: {success: true, message: I18n.t('common.top_success_message')}
    end
  end

  def show
    process_and_respond!( operation: Meat::RequestOperation::Show.new( with_default_params( id: params[:id] ) ) ) do |operation, result|

      respond_to do |format|
        format.html {
          @meta_title = I18n.t('meta.request.title', title: operation.model.category_title, country: operation.model.origins.join(', '))
          @meta_desc = I18n.t('meta.request.description', title: @meta_title)
          render template: "main/index"
        }
        format.json {
          render json: {status: check_page_counter ? 405 : 200, success: true, item: Meat::RequestSerializer::Item.new(result,current_user: current_user, blur_info: check_page_counter) }
        }
      end
    end
  end

  def index
    klass = params[:cabinet] ? Meat::RequestOperation::CabinetList : Meat::RequestOperation::FrontList
    process_and_respond!(operation: klass.new( with_default_params( list_params ) ) ) do |operation, result|
      render json: {
        status: list_params[:page].to_i > 1 && current_user.nil? ? 405 : 200,
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::RequestSerializer::FrontList,
          current_user: current_user
        )
      }
    end
  end

  def list
    process_and_respond!(operation: Meat::RequestOperation::CabinetList.new( with_default_params( page: params[:page] ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::RequestSerializer::Short,
          current_user: current_user
        )
      }
    end
  end

  def create
    process_and_respond!(operation: Meat::RequestOperation::Add.new( with_default_params( request_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def edit
    process_and_respond!(operation: Meat::RequestOperation::Read.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, item: Meat::RequestSerializer::Cabinet.new(result) }
    end
  end
  def update
    process_and_respond!(operation: Meat::RequestOperation::Renew.new( with_default_params( request_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def destroy
    process_and_respond!(operation: Meat::RequestOperation::DestroyWithAuth.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true}
    end
  end


  def send_offers
    process_and_respond!(operation: Meat::RequestOperation::Send.new( with_default_params( send_params.merge(id: params[:id]) ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  private

  def list_params
    _params = params.permit(:page,:title,:sorting,:filters,:by_company)
    _params[:filters] = JSON.load(_params[:filters]) if _params[:filters].presence
    _params[:sorting] = JSON.load(_params[:sorting]) if _params[:sorting].presence
    _params[:company_id] = 0
    _params
  end

  def bid_params
    params.permit(:amount,:currency,:comment,:id)
  end

  def inquiry_params
    params.permit(:message,:title,:sender_email,:id, :phone, :phone_number, :country_code)
  end

  def request_params
    _params = params.permit(:market_param, :active, :price_from, :price_to,:id,:category_id,:quantity,:currency,:description, :certificates, :delivery_conditions, :documents, :payment_types, :permissions_to, :origins)
    [ :certificates, :delivery_conditions, :documents, :payment_types, :permissions_to, :origins].each do |key|
      _params[key] = _params[key].to_s.split(",")
    end
    _params
  end

  def send_params
    params.permit(:id,:comment,ids:[])
  end

end


