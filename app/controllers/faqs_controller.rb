class FaqsController < ApplicationController

  def show
    process_and_respond!(operation: Content::FaqOperation::Read.new( id: params[:id] ) ) do |operation, result|
      render json: {success: true, item: result.text }
    end
  end

  def index
    process_and_respond!(operation: Content::FaqOperation::FrontList.new) do |operation, result|
      render json: {success: true, items: result}
    end
  end

end








