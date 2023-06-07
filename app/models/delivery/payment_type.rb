
module Delivery
  class PaymentType  < ApplicationRecord
    multilang :title
    scope :active_for_offers, ->(){where(active_for_offers: true)}
    scope :active_for_requests, ->(){where(active_for_requests: true)}
    scope :active, ->(){where(active: true)}
  end
end



