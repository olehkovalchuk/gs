module Meat
  module CertificateSerializer
    class Short < BeOneAdmin::Serializer
      attributes :img,:title

      def img
        image_path(object.logo, ActionController::Base.helpers.image_url("certificate.png"), "60x60")
      end

    end
  end
end
