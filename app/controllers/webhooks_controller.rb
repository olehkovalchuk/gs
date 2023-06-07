class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def whatsapp
  end

end
