
module Content
  class Faq  < ApplicationRecord
    multilang :title, :text
    scope :active, ->(){where(active: true)}
  end
end



