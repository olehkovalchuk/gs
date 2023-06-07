class ServicesController < ApplicationController
  def verification
    render layout: "new_layout"
  end
  def safe_deal
    render layout: "new_layout"
  end

  def create
    process_and_respond!(operation: Chat::ContactOperation::Create.new(contact_params), with_redirect_back:true ) do |operation, result|
      flash[:message] = I18n.t("common.please_wait_for_replay")

      flash[:event] = 'SafeDeal'
      flash[:g_event] = 'safe_deal'

      redirect_back fallback_location: root_path
    end
  end

  private

  def contact_params
     params.require(:chat_contact).permit(:email,:text,:name)
  end

end
