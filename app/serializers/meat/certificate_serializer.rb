# == Schema Information
#
# Table name: meat_certificates
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  markets    :string           default(["\"meat\""]), not null, is an Array
#  title      :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_meat_certificates_on_active  (active)
#
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
