class BidsController < ApplicationController

  before_action :require_login

  before_action :require_membership, only: [:create]


  def index
    process_and_respond!(operation: Meat::BidOperation::FrontList.new( with_default_params( page: params[:page] || 1 ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::BidSerializer::List,
          current_user: current_user
        )
      }
    end
  end

  def create
    process_and_respond!(operation: Meat::OfferOperation::Bid.new( with_default_params( item_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def destroy
    process_and_respond!(operation: Meat::BidOperation::DestroyWithAuth.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  private

  def item_params
    params.permit( :amount, :currency, :comment, :id )
  end


end
