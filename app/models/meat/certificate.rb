
module Meat
  class Certificate  < ApplicationRecord
    multilang :title
    has_one_attached :logo
    scope :active, ->(){where(active: true)}
  end
end



