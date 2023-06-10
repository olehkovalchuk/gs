# == Schema Information
#
# Table name: geo_ports
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  code         :string(50)       not null
#  country_code :string(2)        not null
#  latitude     :float            default(0.0), not null
#  longitude    :float            default(0.0), not null
#  region_code  :string(3)        not null
#  title        :jsonb            not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_geo_ports_on_active        (active)
#  index_geo_ports_on_code          (code)
#  index_geo_ports_on_country_code  (country_code)
#  index_geo_ports_on_region_code   (region_code)
#
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



