class MainController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :log
  skip_before_action :require_verification
  def index
    @show_map = true
    ::KibanaLogger.push("show_page",{})
    if is_lighthouse
      render  layout: "new_layout", action: "landing"
      return
    end
  
  end

  def email
    render layout: false
  end

  def for_buyer
    @items = ::Order::Package.active.where('price > 0').all
    @end_date = Time.at(cookies[:timer].to_i / 1000) rescue (Time.current + 1.day)
    cookies[:timer] = @end_date.to_i * 1000
    render layout: "new_layout"
   end
  def for_seller
    @items = ::Order::Package.active.where('price > 0').all
    @end_date = Time.at(cookies[:timer].to_i / 1000) rescue (Time.current + 1.day)
    cookies[:timer] = @end_date.to_i * 1000
    render layout: "new_layout"
  end

  def pricing
    @items = ::Order::Package.active.all
    @categories = ::Order::ServiceCategory.includes(:service_items).active.all

    ::KibanaLogger.push("show_page",{})
    render layout: "new_layout"
  end

  def marketplace
    process_and_respond!(operation: MarketplaceOperation.new(with_default_params) ) do |operation, result|
      render json: result.merge({success: true})
    end
  end

  def contact
    process_and_respond!(operation: Chat::ContactOperation::Create.new(contact_params) ) do |operation, result|
      render json: {success: true, message: 'Thank you for contacting Global Supplies. We will reach you shortly. Feel free to visit our marketplace and look for best meat offers and suppliers on our platform' }
    end
  end

  def feedback
    process_and_respond!(operation: Chat::FeedbackOperation::Create.new( with_default_params(feedback_params) ) ) do |operation, result|
      render json: {success: true}
    end
  end

  def faq
    ::KibanaLogger.push("show_page",{})
    render layout: "new_layout"
  end

  def about
    ::KibanaLogger.push("show_page",{})
    render layout: "new_layout"
  end

  def how_it_works
    ::KibanaLogger.push("show_page",{})
    render layout: "new_layout"
  end

  def landing
    @style = "landing"
    ::KibanaLogger.push("show_page",{})
    render layout: "new_layout"
  end

  def login
    ::KibanaLogger.push("show_page",{})
  end

  def restore_password
    flash.now[:show_restore] = true
    ::KibanaLogger.push("show_page",{})
    render  layout: "new_layout", action: "landing"
  end

  def inq_restore_password
    flash.now[:reset_token] = params[:token]
    flash[:restore_action] =  reg_inq_path

    ::KibanaLogger.push("show_page",{})
    render  layout: "new_layout", action: "landing"
  end

  def subscribe
    process_and_respond!(operation: SubscriberOperation::Create.new( subscribe_params.merge(captcha: params["g-recaptcha-response"]) ),with_redirect_back:true ) do |operation, result|
      flash[:message] = I18n.t("common.subscribe_finished")
      flash[:event] = 'SubscribeToNews'
      flash[:g_event] = 'subscribe_to_news'
      redirect_to articles_path
    end
  end

  def subscribe_from_pricing
    process_and_respond!(operation: SubscriberOperation::Create.new( subscribe_params ),with_redirect_back:true ) do |operation, result|
      flash[:message] = I18n.t("common.subscribe_finished")
      flash[:event] = 'PricingCallMe'
      flash[:g_event] = 'pricing_call_me'
      redirect_to pricing_path
    end
  end

  def subscribe_from_benefit
    process_and_respond!(operation: SubscriberOperation::Create.new( subscribe_params ) ) do |operation, result|
      render json: {success: true, message: 'Thanks! Manager will call you in 15 minutes'}
    end
  end

  def seo_page
    ::KibanaLogger.push("show_page", seo_page_params.to_unsafe_h.symbolize_keys )
    process_and_respond!(operation: Content::SeoPageOperation::Get.new( seo_page_params ) ) do |operation, result|
      @text = operation.text
      @meta_title = operation.meta_title
      @title = operation.title
      @id = operation.id || 0
      @description = operation.description
      render layout: "new_layout"
    end
  end

  def log
    Journal.push(log_params)
    head :ok
  end


  def error
    @code = params[:code] || 500

    respond_to do |format|
      format.html { render layout: "new_layout", status: @code }
    end


  end

  private


  def seo_page_params
    params.permit(:country_code,:category_seo,:marketplace_type)
  end


  def subscribe_params
    params.require(:subscriber).permit(:email)
  end

  def log_params
     params.permit(:status,:message)
  end


  def contact_params
     params.permit(:email,:text,:name)
  end

  def feedback_params
     params.permit(:text)
  end

end

