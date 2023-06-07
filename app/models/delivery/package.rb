
module Delivery
  class Package  < ApplicationRecord
    multilang :title
    scope :active, ->(){where(active: true)}
  end
end



