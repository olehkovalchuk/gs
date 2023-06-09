# == Schema Information
#
# Table name: geo_regions
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(TRUE), not null
#  active_for_offers   :boolean          default(TRUE), not null
#  active_for_requests :boolean          default(TRUE), not null
#  code                :string(2)        not null
#  title               :jsonb            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_geo_regions_on_code  (code)
#
module Geo
  class Region  < ApplicationRecord
    multilang :title
    scope :active_for_offers, ->(){where(active_for_offers: true)}
    scope :active_for_requests, ->(){where(active_for_requests: true)}
    scope :active, ->(){where(active: true)}

    has_many :countries, class_name: "Geo::Country", foreign_key: :region_code, primary_key: :code
  end
end



