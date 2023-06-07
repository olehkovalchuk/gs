class SubscriptionsController < ApplicationController
  before_action :require_login
  def show
    process_and_respond!(operation: Meat::SubscriptionOperation::Read.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, item: Meat::SubscriptionSerializer::Item.new(result) }
    end
  end

  def index
    process_and_respond!(operation: Meat::SubscriptionOperation::FrontList.new( with_default_params( page: (params[:page] || 1) ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::SubscriptionSerializer::List
        )
      }
    end
  end

  def create
    process_and_respond!(operation: Meat::SubscriptionOperation::Create.new( with_default_params( item_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def destroy
    process_and_respond!(operation: Meat::SubscriptionOperation::Destroy.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  private

  def item_params
    params.permit(:category_ids, :type)
  end


end


