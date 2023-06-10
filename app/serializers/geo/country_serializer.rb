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
  class CountrySerializer
    class Short < ActiveModel::Serializer
      attributes :code,:title

    end
  end
end
