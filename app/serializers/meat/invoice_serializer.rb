# == Schema Information
#
# Table name: meat_invoices
#
#  id              :bigint           not null, primary key
#  comment         :text
#  status          :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer          not null
#  company_user_id :integer          not null
#  process_id      :integer
#
# Indexes
#
#  index_meat_invoices_on_company_id       (company_id)
#  index_meat_invoices_on_company_user_id  (company_user_id)
#
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
