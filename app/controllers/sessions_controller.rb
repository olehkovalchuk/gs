class SessionsController < ApplicationController

  before_action :require_login, only: [:logout]

  skip_before_action :require_verification

  def sign_in
    process_and_respond!(operation: Meat::CompanyUserOperation::SignIn.new( with_default_params( sign_in_params ) ) ) do |operation, result|
      session[:user_token] = result
      render json: {success: true, user: Meat::CompanyUserSerializer::Base.new( operation.model ) }
    end
  end
  def sign_up
    process_and_respond!(operation: Meat::CompanyUserOperation::SignUp.new( with_default_params( sign_up_params ) ) ) do |operation, result|
      flash[:message] = I18n.t('common.not_verificated', email: operation.model.email, link: verify_link )
      render json: {success: true, redirect: thank_you_path   }
    end
  end

  def logout
    process_and_respond!(operation: Meat::CompanyUserOperation::Logout.new(with_default_params), with_redirect_back: true ) do |operation, result|
      redirect_to marketplace_url(market: nil)
    end
  end

  def verify
    process_and_respond!(operation: Meat::CompanyUserOperation::Verify.new( with_default_params( code: params[:code] ) ), with_redirect_back: true ) do |operation, result|
      # session[:user_token] = result
      flash[:message] = I18n.t("common.you_are_verified")
      flash[:event] = 'CompleteRegistration'
      flash[:g_event] = 'complete_registration'

      redirect_back fallback_location: marketplace_path
    end
  end

  def resend
    process_and_respond!(operation: Meat::CompanyUserOperation::ResendVerify.new( with_default_params ), with_redirect_back: true ) do |operation, result|
      flash[:message] = I18n.t("common.check_your_email")
      redirect_to root_path
    end
  end

  def remind
    process_and_respond!(operation: Meat::CompanyUserOperation::Restore.new( with_default_params( restore_params ) ) ) do |operation, result|
      render json: {success: true, message: I18n.t("common.instructions_was_sended_to_email") }
    end
  end

  def restore
    if request.xhr?
      process_and_respond!(operation: Meat::CompanyUserOperation::ChangePassword.new( with_default_params( token: params[:token], password: params[:password], password_confirmation: params[:password_confirmation]) ) ) do |operation, result|
        session[:user_token] = result
        render json: {success: true, user: Meat::CompanyUserSerializer::Base.new( operation.model ), id: operation.model.received_conversations.last.id,   message: I18n.t("common.you_can_login_with_new_password") }
      end
    else
      process_and_respond!(operation: Meat::CompanyUserOperation::CheckResetPassword.new( with_default_params( token: params[:token] ) ), with_redirect_back: true ) do |operation, result|
        flash.now[:reset_token] = params[:token]
        render template: "main/landing", layout: 'new_layout'
      end
    end
  end

  def reg_inq
    if request.xhr?
      process_and_respond!(operation: Meat::CompanyUserOperation::ChangePassword.new( with_default_params( token: params[:token], password: params[:password], password_confirmation: params[:password_confirmation]) ) ) do |operation, result|
        render json: {success: true, message: I18n.t("common.you_can_login_with_new_password") }
      end
    else
      process_and_respond!(operation: Meat::CompanyUserOperation::CheckResetPassword.new( with_default_params( token: params[:token] ) ), with_redirect_back: true ) do |operation, result|
        flash[:reset_token] = params[:token]
        redirect_to root_url
      end
    end
  end


  private

  def sign_in_params
    params.require(:user).permit(:email,:password)
  end

  def sign_up_params
    _params = params.require(:user).permit(:captcha, :role, :email,:password,:password_confirmation,:agree,:phone,:first_name,:last_name, :company_name, :country_code, :phone_number)
    _params[:skip_captcha] = session[:skip_captcha].present?
    _params
  end

  def restore_params
    _params = params.require(:user).permit(:email, :captcha)
    _params[:skip_captcha] = session[:skip_captcha].present?
    _params
  end

end






