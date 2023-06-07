class AlertsController < ApplicationController

  before_action :require_login

  def create
    process_and_respond!(operation: Meat::AlertOperation::Create.new( with_default_params( item_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  private

  def item_params
    params.permit(:category_id)
  end

end