
module Geo
  class Country  < ApplicationRecord
    multilang :title
    belongs_to :region, foreign_key: :region_code, primary_key: :code
    delegate :title, to: :region, prefix: true

    scope :active_offers_permission, ->(){where(active_offers_permission: true)}
    scope :active_requests_permission, ->(){where(active_requests_permission: true)}
    scope :active_offers_origin, ->(){where(active_offers_origin: true)}
    scope :active_requests_origin, ->(){where(active_requests_origin: true)}
  end
end

