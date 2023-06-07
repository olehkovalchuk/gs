module Meat
  module InvoiceSerializer
    class List < BeOneAdmin::Serializer
      DATE_FORMAT = "%d %b %Y"
      attributes :id,:created_at,:status, :user, :deletable

      def status
        I18n.t("common.ivoice_statuses.#{object.status}")
      end

      def created_at
        object.created_at.strftime(DATE_FORMAT)
      end

      def user
        Meat::CompanyUserSerializer::Base.new(object.company_user)
      end

      def deletable 
        !object.approved?
      end
    end
  end
end
