
module Geo
  class Region  < ApplicationRecord
    multilang :title
    scope :active_for_offers, ->(){where(active_for_offers: true)}
    scope :active_for_requests, ->(){where(active_for_requests: true)}
    scope :active, ->(){where(active: true)}

    has_many :countries, class_name: "Geo::Country", foreign_key: :region_code, primary_key: :code
  end
end



