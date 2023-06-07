class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :set_front_locale
  before_action :setup_js_configs
  helper_method :application_config
  helper_method :current_user
  helper_method :is_lighthouse
  around_action :set_globals
  before_action :require_verification, except: [:require_login]

  def set_front_locale
    if params[:utm_source].presence
      cookies[:g_utm_source] = params[:utm_source]
      cookies[:g_utm_medium] = params[:utm_medium]
      cookies[:g_utm_campaign] =  params[:utm_campaign]
    end
    RequestStore.store[:kibana_data] = {
      user_ip: request.remote_ip,
      market: params[:market],
      user_agent: request.user_agent,
      controller: params[:controller],
      action: params[:action],
      current_refid: current_refid,
      current_refid_name: current_refid_name,
      current_email: current_user.try(:email) || "unauthorized",
      current_company: current_user.try(:company).try(:title) || "unauthorized",
      location: GeoLocation.location( request.remote_ip ),
      uniq_token: cookies[:uniq_token],
      utm_source: cookies[:g_utm_source].to_s,
      utm_medium: cookies[:g_utm_medium].to_s,
      utm_campaign: cookies[:g_utm_campaign].to_s,
    }
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_refid
    return @current_refid if defined?(@current_refid)
    refid =
      if !cookies[:refid].to_i.zero?
        cookies[:refid]
      elsif params[:refid].presence
        Traffic::Source.find_by(id: params[:refid])&.id
      else
        nil
      end
    @current_refid = refid.to_i
    cookies[:refid] = @current_refid
    @current_refid
  end

  def current_refid_name
    current_refid.zero? ? 'none' : Traffic::Source.find_by(id: params[:refid])&.name
  end


  def set_globals
    if ['html','json','application/json','text/html'].include?(request.format.to_s)
      RequestStore.store[:journal_parametrizer] = ::FrontLogger
      ::Journal.safe_action(params.to_unsafe_h.merge(has_parent: false, args: params.to_unsafe_h.except('controller', 'action'))) do
        set_user_token
        application_config
        RequestStore.store[:request_id] = request.env['action_dispatch.request_id']
        RequestStore.store[:request] = request
        RequestStore.store[:uniq_token] = cookies[:uniq_token]
        if session[:user_token]
          RequestStore.store[:current_user] = current_user
          session.delete(:user_token) unless !!RequestStore.store[:current_user]
        end
        yield
      end
    else
      yield
    end
  end

  def default_url_options
    Rails.application.routes.default_url_options[:host] = Rails.application.secrets[:app_host]
    { trailing_slash: true, host: Rails.application.secrets[:app_host], locale: I18n.locale == I18n.default_locale ? nil : I18n.locale, market: params[:market] || DEFAULT_MARKET }
  end

  def current_user
    return @current_user if @current_user
    @current_user = RequestStore.store[:current_user] =  Meat::CompanyUserOperation::Authentificate.new(token: session[:user_token], ip: request.remote_ip, user_agent: request.user_agent).process if session[:user_token]
  end

  protected

    def process_and_respond!(operation:, with_redirect_back: false, show_404: false, disallow_access: false)

      if disallow_access
        respond_to do |format|
          format.html {
            flash[:message] = I18n.t("common.limit_reached")
            flash[:error] = :restricted
            if with_redirect_back
              redirect_back(fallback_location: root_path, market: nil)
            end
            if show_404
              raise ActionController::RoutingError.new('Not Found')
            end
          }
          response = {success: false, error: :restricted, message: I18n.t("common.limit_reached"), status: 405 }
          RequestStore.store[:response_body] = response
          format.json { render json: response }
        end
      else
        if result = operation.process
          yield operation, result
        else
          session[:skip_captcha] = true if Thread.current[:skip_captcha]
          error = Array.wrap(operation.errors.values[0]).flatten[0]
          error_key = Array.wrap(operation.errors.keys[0]).flatten[0]
          respond_to do |format|
            format.html {
              # flash[:message] = error
              flash[:error] = error_key
              if with_redirect_back
                redirect_back(fallback_location: root_path, market: nil)
              end
              if show_404
                raise ActionController::RoutingError.new('Not Found')
              end
            }
            response = {success: false, error: error_key, message: error, status: (error_key == :not_allowed ? 405 : 200) }
            RequestStore.store[:response_body] = response
            format.json { render json: response }
          end
        end
      end

    end


  def check_page_counter
    true
  end

  def set_locale
    cookies[:locale] = current_user.try(:locale) unless I18n.available_locales.include?(cookies[:locale].to_s.to_sym)
    I18n.with_locale(cookies[:locale]) do
      yield
    end
  end

  def require_verification
    if current_user && !current_user.verificated_email
      message = I18n.t('common.not_verificated', email: current_user.email, link: verify_link )
      if request.xhr?
        render_as_json( { success: false, message: message, status: 403 } )
      else
        flash[:message] = message
        redirect_to root_path
      end
    end
    return true
  end

  def require_login
    if current_user
      RequestStore.store[:resource_scope] = {}
    else
      if request.xhr?
        render_as_json( { success: false, message: I18n.t( "common.#{params[:controller]}_#{params[:action]}_login" , default: I18n.t('common.session_expired')), status: 401 } )
      else
        redirect_to root_path
      end
    end
  end

  def require_membership
    unless current_user.presenter.has_payed_subscription?
      if request.xhr?
        render_as_json( { success: false, message: I18n.t( "common.#{params[:controller]}_#{params[:action]}_membership" , default: I18n.t('common.membership_expired')), status: 426 } )
      else
        redirect_to root_path
      end
    end
  end

  def set_user_token
    cookies[:uniq_token] = get_new_token unless "#{cookies[:uniq_token]}".first(4) == Time.zone.now.strftime('%d%m')
  end

  def get_new_token
    [Time.zone.now.strftime('%d%m'), 6.times.map{ rand(9) }.join].join
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-CSRF-TOKEN']) || valid_authenticity_token?(session, request.headers['X-XCRF-TOKEN'.downcase]) || params[:authenticity_token]
  end

  def setup_js_configs
    gon.config = application_config
    gon.message = flash[:message]
  end
  def application_config
    {
      host: Rails.application.secrets[:app_host],
      base_url: ((marketplace_path(market: DEFAULT_MARKET == params[:market] ? nil : params[:market])) rescue nil),
      market: params[:market] || DEFAULT_MARKET,
      ws_protocol: Rails.application.secrets[:ws_protocol] || 'ws',
      roles: ['seller','buyer','trader'].map{|d| {id: d, title: I18n.t("common.company_info.roles.#{d}")} },
      markets: AVAILABLE_MARKETPLACES.map{|d| {id: d, title: I18n.t("common.marketplaces.#{d}")} },
      country: user_country,
      is_lighthouse: is_lighthouse,
      inquiry: inquiry_text.present? ? params[:inquiry_id] : nil,
      inquiry_text: inquiry_text,
      prices: Order::Package.active.where('price > 0').map{|d| {id: d.id, title: d.title} },
      show_map: 'index' == params[:action]  && 'main' == params[:controller] #pizdec net vremeni
    }
  end

  def inquiry_text
    if params[:inquiry_id].presence
      @parent_inqury ||= ::Chat::Inquiry.find_by(inquiry_email: "inquiries+#{params[:inquiry_id]}@globsupplies.com")
      return @parent_inqury.message if @parent_inqury
    end
    return nil
  end

  def user_country
    @country ||= GeoLocation.country_code( request.remote_ip )
    @country == '--' ? 'UA' : @country
  end

  def is_lighthouse 
    @is_lighthouse ||= request.user_agent.to_s.match("Chrome-Lighthouse").present?
  end

  def with_default_params( _params = {} )
    {
      current_user: current_user&.presenter,
      company_user_id: current_user&.id,
      company_id: current_user&.company_id,
      token: session[:user_token],
      ip: request.remote_ip,
      referer: request.referer,
      user_agent: request.user_agent,
      user_country: user_country,
      market: params[:market].presence || DEFAULT_MARKET
    }.merge(_params)
  end

end
