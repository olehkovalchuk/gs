class NotificationsController < ApplicationController

  before_action :require_login
  
  def index
    process_and_respond!(operation: Chat::NotificationOperation::CabinetList.new( with_default_params( page: params[:page] ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Chat::NotificationSerializer::List
        )
      }
    end
  end

  def show
    process_and_respond!(operation: Chat::NotificationOperation::Read.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {
        success: true
      }
    end
  end

end
