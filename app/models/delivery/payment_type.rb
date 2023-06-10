# == Schema Information
#
# Table name: delivery_payment_types
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(FALSE)
#  active_for_offers   :boolean
#  active_for_requests :boolean
#  has_prepay          :boolean          default(FALSE)
#  title               :jsonb            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_delivery_payment_types_on_active  (active)
#
module Delivery
  class PaymentType  < ApplicationRecord
    multilang :title
    scope :active_for_offers, ->(){where(active_for_offers: true)}
    scope :active_for_requests, ->(){where(active_for_requests: true)}
    scope :active, ->(){where(active: true)}
  end
end



