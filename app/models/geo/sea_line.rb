# == Schema Information
#
# Table name: geo_sea_lines
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  code       :string
#  active     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Geo 
  class SeaLine  < ApplicationRecord
    scope :active, ->(){where(active: true)}
  end
end



