module Meat
  class Document  < ApplicationRecord
    multilang :title
    scope :active_for_offer, ->(){where(active_for_offer: true)}
    scope :active_for_po, ->(){where(active_for_po: true)}
    scope :need_sign, ->(){where(need_sign: true)}
  end
end