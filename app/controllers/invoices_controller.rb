class InvoicesController < ApplicationController

  before_action :require_login

  def show
    process_and_respond!(operation: Meat::InvoiceOperation::Item.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      redirect_to url_for( result.file )
    end
  end

  def index
    process_and_respond!(operation: Meat::InvoiceOperation::FrontList.new( with_default_params( page: (params[:page] || 1) ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::InvoiceSerializer::List
        )
      }
    end
  end

  def create
    process_and_respond!(operation: Meat::InvoiceOperation::Create.new( with_default_params( item_params ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def destroy
    process_and_respond!(operation: Meat::InvoiceOperation::Destroy.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  private

  def item_params
    params.permit(:file, :comment)
  end


end


    # [
    #     {id: '1', status: 'Destination place', status: 'Approved', date: '21/10/019'},
    #     {id: '1', status: 'Destination place', status: 'Approved', date: '21/10/019'},
    #     {id: '1', status: 'Destination place', status: 'Approved', date: '21/10/019'},
    #     {id: '1', status: 'Destination place', status: 'Approved', date: '21/10/019'},
    #     {id: '1', status: 'Destination place', status: 'Approved', date: '21/10/019'},
    #     {id: '1', status: 'Destination place', status: 'Approved', date: '21/10/019'},
    #   ]





