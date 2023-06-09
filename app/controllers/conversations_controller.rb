class ConversationsController < ApplicationController

  before_action :require_login, except: [:inquiry]

  # before_action :require_membership, only: :create 
  
  def index
    process_and_respond!(operation: Chat::ConversationOperation::CabinetList.new( with_default_params(page: params[:page]) ) ) do |operation, result|
      render json:(
        {
          success: true,
          items: ActiveModelSerializers::SerializableResource.new(
            result,
            each_serializer: Chat::ConversationSerializer::List,
            current_user: current_user
          ),
        }
      )
    end
  end

  def show
    process_and_respond!(operation: Chat::MessageOperation::CabinetList.new( with_default_params(id: params[:id]) ) ) do |operation, result|
      render json:(
        {
          success: true,
          item: Chat::ConversationSerializer::List.new( operation.model, current_user: current_user ),
          items: ActiveModelSerializers::SerializableResource.new(
            result,
            each_serializer: Chat::MessageSerializer::List,
            current_user: current_user
          ),
        }
      )
    end
  end

  def create
    process_and_respond!(operation: Chat::ConversationOperation::AddMessage.new( with_default_params(message_params) ) ) do |operation, result|
      render json: { success: true, id: result.id }
    end
  end

  def inquiry
    process_and_respond!(operation: Chat::InquiryOperation::Replay.new( with_default_params(message_params) ) ) do |operation, result|
      render json: {success: true, message: I18n.t('common.inquiry_replayed')}
    end
  end

  def destroy
    process_and_respond!(operation: Chat::ConversationOperation::Destroy.new( with_default_params(message_params) ) ) do |operation, result|
      render json: { success: true }
    end
  end

  private

  def message_params
    params.permit(:id, :message, :file,:recepient_id)
  end


end
