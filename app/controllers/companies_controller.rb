class CompaniesController < ApplicationController

  before_action :require_login, except:[:show,:index,:products,:offers,:requests, :rating]

  def info
    process_and_respond!(operation: Meat::CompanyOperation::Read.new( with_default_params( id: current_user.company_id ) ) ) do |operation, result|
      render json: {status: check_page_counter ? 405 : 200, success: true, item: Meat::CompanySerializer::Info.new(result, blur_info: current_user.nil?, current_user: current_user) }
    end
  end

  def update
    process_and_respond!(operation: Meat::CompanyOperation::Update.new( with_default_params( company_params.merge(id: current_user.company_id ) ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def edit
    process_and_respond!(operation: Meat::CompanyOperation::Read.new( with_default_params( id: current_user.company_id ) ) ) do |operation, result|
      render json: {success: true, item: Meat::CompanySerializer::Edit.new(result, current_user: current_user) }
    end
  end

  def show
    process_and_respond!(operation: Meat::CompanyOperation::Read.new( with_default_params( id: params[:id], page: params[:page] ) ) ) do |operation, result|
      render json: {status: check_page_counter ? 405 : 200, success: true, item: Meat::CompanySerializer::Info.new(result, blur_info: current_user.nil?, current_user: current_user )  }
    end
  end

  def contacts
    process_and_respond!(operation: Meat::CompanyOperation::ReadForContacts.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {status: 200, success: true, item: Meat::CompanySerializer::Contacts.new(result, blur_info: false, current_user: current_user )  }
    end
  end

  def index
    process_and_respond!(operation: Meat::CompanyOperation::FrontList.new( with_default_params(list_params) ) ) do |operation, result|
      render json: {success: true, items: ActiveModelSerializers::SerializableResource.new(result,each_serializer: Meat::CompanySerializer::MapList, current_user: current_user ) }
    end
  end

  def products
    process_and_respond!(operation: Meat::CompanyOperation::ProductList.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, items: result}
    end
  end

  def offers
    process_and_respond!(operation: Meat::OfferOperation::FrontList.new( with_default_params( company_id: params[:id], page: params[:page] || 1 ) ) ) do |operation, result|
      render json: {
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

  def requests
    process_and_respond!(operation: Meat::RequestOperation::FrontList.new( with_default_params( company_id: params[:id], page: params[:page] || 1 ) ) ) do |operation, result|
      render json: {
        success: true,
        total: result,
        items: ActiveModelSerializers::SerializableResource.new(
          operation.model,
          each_serializer: Meat::RequestSerializer::FrontList,
          current_user: current_user
        )
      }
    end
  end

  def chart
    process_and_respond!(operation: Meat::CompanyOperation::Chart.new( with_default_params(chart_params) ) ) do |operation, result|
      render json:(
        {
          success: true,
          item: Meat::CompanySerializer::Charts.new(result)
        }
      )
    end
  end

  def document
    process_and_respond!(operation: Meat::CompanyOperation::AddDocuments.new( with_default_params( documents_params.merge(id: current_user.company_id ) ) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def rating
    process_and_respond!(operation: Meat::CompanyOperation::Read.new( with_default_params( id: params[:id] ) ) ) do |operation, result|
      render json: {success: true, item: Meat::CompanySerializer::Rating.new(result) }
    end
  end


  private

  def list_params
    _params = params.permit(:sorting,:filters)
    _params[:filters] = JSON.load(_params[:filters]) if _params[:filters].presence
    _params[:sorting] = JSON.load(_params[:sorting]) if _params[:sorting].presence
    _params
  end

  def company_params
    _params = params.permit(:title, :certificates, :logo, :zip_address, :bank_country, :bank, :city, :country_code, :role, :about, :address, :total_emploees, :year_establishment, :plant_number, :representative, :iban, :swift, :tic, :vat, :eori, :account_number, :zip )
    [ :certificates ].each do |key|
      _params[key] = _params[key].to_s.split(",")
    end
    _params
  end


  def chart_params
    params.permit(:period, :chart )
  end

  def documents_params
    params.permit( :passport, :bill )
  end
end
