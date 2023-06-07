class MembersController < ApplicationController

  before_action :require_login, except: [:new_messages_count]

  def show
    process_and_respond!(operation: Meat::CompanyUserOperation::ReadItem.new(with_default_params(id:params[:id]))) do |operation, result|
      render json: {success: true, item: Meat::CompanyUserSerializer::Full.new(current_user) }
    end
  end

  def edit
    process_and_respond!(operation: Meat::CompanyUserOperation::ReadItem.new(with_default_params(id:params[:id]))) do |operation, result|
      render json: {success: true, item: Meat::CompanyUserSerializer::Edit.new(result) }
    end
  end

  def new_messages_count
    render json: {success: true, count: current_user.try(:new_messages_count).to_i, success: current_user.present?, count_notifications: current_user.try(:new_notifications_count).to_i }
  end

  def index
    process_and_respond!(operation: Meat::CompanyOperation::Members.new( with_default_params(with_fake: params[:with_fake]) ) ) do |operation, result|
      render json:(
        {
          success: true,
          items: ActiveModelSerializers::SerializableResource.new(
            result,
            each_serializer: Meat::CompanyUserSerializer::List
          )
        }
      )
    end
  end

  def create
    process_and_respond!(operation: Meat::CompanyOperation::AddMember.new( with_default_params( user_params.merge(id: current_user.company_id, password: (0...8).map { (65 + rand(26)).chr }.join ) ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def update
    process_and_respond!(operation: Meat::CompanyUserOperation::UpdateMember.new( with_default_params( user_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end


  def destroy
    process_and_respond!(operation: Meat::CompanyUserOperation::Destroy.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def chart
    process_and_respond!(operation: Meat::CompanyUserOperation::Chart.new( with_default_params ) ) do |operation, result|
      render json:(
        {
          success: true,
          item: Meat::CompanyUserSerializer::Charts.new(result)
        }
      )
    end
  end

  private

  def user_params
    params.permit(:id, :last_name, :first_name, :email, :country_code, :avatar, :phone, :phone_number, :title )
  end
end
