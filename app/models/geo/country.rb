# == Schema Information
#
# Table name: geo_countries
#
#  id                         :bigint           not null, primary key
#  active_offers_origin       :boolean          default(FALSE)
#  active_offers_permission   :boolean          default(FALSE)
#  active_requests_origin     :boolean          default(FALSE)
#  active_requests_permission :boolean          default(FALSE)
#  code                       :string(2)        not null
#  region_code                :string(3)        not null
#  title                      :jsonb            not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_geo_countries_on_code         (code)
#  index_geo_countries_on_region_code  (region_code)
#
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

