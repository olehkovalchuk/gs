# == Schema Information
#
# Table name: delivery_conditions
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(FALSE)
#  active_for_offers   :boolean
#  active_for_requests :boolean
#  code                :string(3)        not null
#  need_buyer_country  :boolean          default(FALSE), not null
#  need_buyer_port     :boolean          default(FALSE), not null
#  need_sea_line       :boolean          default(FALSE)
#  need_seller_country :boolean          default(FALSE), not null
#  need_seller_port    :boolean          default(FALSE), not null
#  safe_deal           :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_delivery_conditions_on_active  (active)
#  index_delivery_conditions_on_code    (code)
#
module Delivery
  class Condition  < ApplicationRecord
    scope :active_for_offers, ->(){where(active_for_offers: true)}
    scope :active_for_requests, ->(){where(active_for_requests: true)}
    scope :active, ->(){where(active: true)}
    scope :not_for_safe, ->(){where(safe_deal: [false,nil])}

    has_many :steps, class_name: "Delivery::Step", foreign_key: :delivery_code , primary_key: :code
  end
end



