module Admin
  class UploadsController < Admin::ApplicationController
    skip_before_action :verify_authenticity_token
    def images
      image = ::Content::Image.create!(params.permit(:file))
      render json: {success: true, location: image.file.try(:service_url) }
    end
  end
end