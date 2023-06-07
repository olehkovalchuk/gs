class QuickOffersController < ApplicationController

  def create
    process_and_respond!(operation: Meat::QuickOfferOperation::Create.new( with_default_params( offer_params ) ) ) do |operation, result|
      render json: {success: true, id: operation.model.id, message: 'Congratulations, you have added your proposal. After moderation you will receive an confirmation email.To add more offer please login in your free account and use all power of the marketplace' }
    end
  end

  def offer_params
    params.permit( :email, :price, :country_code, :category_id, images: [] )
  end
end
