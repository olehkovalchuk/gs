class OffersController < ApplicationController

  before_action :require_login, except:[:show,:index,:inquiry]

  def bid
    process_and_respond!(operation: Meat::OfferOperation::Bid.new( with_default_params( bid_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def inquiry
    process_and_respond!(operation: Meat::OfferOperation::Inquiry.new( with_default_params( inquiry_params ) ) ) do |operation, result|
      render json: {success: true, message: I18n.t('common.inquiry_saved')}
    end
  end

  def to_top
    process_and_respond!(operation: Meat::OfferOperation::MoveToTop.new( with_default_params( id: params[:id]  ) ) ) do |operation, result|
      render json: {success: true, message: I18n.t('common.top_success_message')}
    end
  end

  def send_to_promote
    process_and_respond!(operation: Meat::OfferOperation::SendToPromote.new( with_default_params( ids: params[:ids], promo_type: params[:promo_type]  ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def show
    process_and_respond!( operation: Meat::OfferOperation::Show.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      respond_to do |format|
        format.html {
          @meta_title = I18n.t('meta.offer.title', title: operation.model.category_title, country: operation.model.origin_country_title)
          @meta_desc = I18n.t('meta.offer.description', title: @meta_title)
          @meta_image = operation.model.images.first&.service_url
          render template: "main/index"
        }
        format.json {
          render json: {status: check_page_counter ? 405 : 200, success: true, item: Meat::OfferSerializer::Item.new(result,current_user: current_user, blur_info: check_page_counter) }
        }
      end
    end
  end

  def edit
    process_and_respond!(operation: Meat::OfferOperation::Read.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, item: Meat::OfferSerializer::Cabinet.new(result) }
    end
  end

  def remove_attach
    process_and_respond!( operation: Meat::OfferOperation::RemoveAttach.new( with_default_params( id: params[:id], attach_type: params[:attach_type] , attach_id: params[:attach_id] ) ) ) do |operation, result|
      render json: {success: true }
    end
  end

  def index
    klass = params[:cabinet] ? Meat::OfferOperation::CabinetList : Meat::OfferOperation::FrontList
    process_and_respond!(operation: klass.new( with_default_params( list_params ) ) ) do |operation, result|
      render json: {
        status: list_params[:page].to_i > 1 && current_user.nil? ? 405 : 200,
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::OfferSerializer::FrontList,
          current_user: current_user
        )
      }
    end
  end

  def for_promote
    process_and_respond!(operation: Meat::OfferOperation::CabinetList.new( with_default_params( list_params.merge(skip_limit: true)  ) ) ) do |operation, result|
      render json: {
        status: list_params[:page].to_i > 1 && current_user.nil? ? 405 : 200,
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::OfferSerializer::FrontList,
          current_user: current_user
        )
      }
    end
  end

  def list
    process_and_respond!(operation: Meat::OfferOperation::CabinetList.new( with_default_params( page: params[:page] ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::OfferSerializer::Short,
          current_user: current_user
        )
      }
    end
  end

  def create
    process_and_respond!(operation: Meat::OfferOperation::Add.new( with_default_params( item_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def edit
    process_and_respond!(operation: Meat::OfferOperation::Read.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, item: Meat::OfferSerializer::Cabinet.new(result) }
    end
  end

  def update
    process_and_respond!(operation: Meat::OfferOperation::Renew.new( with_default_params( item_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def destroy
    process_and_respond!(operation: Meat::OfferOperation::DestroyWithAuth.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true}
    end
  end


  def delete_image
    process_and_respond!(operation: Meat::OfferOperation::DeleteImage.new( with_default_params( id: params[:id], image_id: params[:id] ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def my
    process_and_respond!(operation: Meat::OfferOperation::CabinetList.new( with_default_params( page: 1, filters: {active:true} ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::OfferSerializer::Short,
          current_user: current_user
        )
      }
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
    params.permit(:message,:title,:sender_email,:id, :post_request, :phone, :phone_number, :country_code)
  end

  def item_params
    _params = params.permit(:market_param, :active, :week_from, :week_to,:price_from, :price_to,:delivery_port, :plant_number,  :id,:origin,:category_id,:quantity,:currency,:description, :packages,:certificates, :delivery_conditions, :documents, :payment_types, :permissions_to,:weight_from,:weight_to,:length_from,:length_to,:weight_type,:length_type, images:{})
    [ :certificates, :delivery_conditions, :documents, :payment_types, :permissions_to, :packages].each do |key|
      _params[key] = _params[key].to_s.split(",")
    end
    _params[:images] = params[:images].to_unsafe_h.values if _params[:images].presence
    _params
  end


end








