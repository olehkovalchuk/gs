
module Delivery
  class Condition  < ApplicationRecord
    scope :active_for_offers, ->(){where(active_for_offers: true)}
    scope :active_for_requests, ->(){where(active_for_requests: true)}
    scope :active, ->(){where(active: true)}
    scope :not_for_safe, ->(){where(safe_deal: [false,nil])}

    has_many :steps, class_name: "Delivery::Step", foreign_key: :delivery_code , primary_key: :code
  end
end



