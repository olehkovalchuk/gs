
module Geo 
  class SeaLine  < ApplicationRecord
    scope :active, ->(){where(active: true)}
  end
end



