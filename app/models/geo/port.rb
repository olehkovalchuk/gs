
module Geo
  class Port  < ApplicationRecord
    multilang :title
    belongs_to :region, foreign_key: :region_code, primary_key: :code
    belongs_to :country, foreign_key: :country_code, primary_key: :code
    delegate :title, to: :region, prefix: true
    delegate :title, to: :country, prefix: true
    scope :active, ->(){where(active: true)}
  end
end



