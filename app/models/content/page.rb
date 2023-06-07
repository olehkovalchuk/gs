
module Content
  class Page  < ApplicationRecord
    multilang :title, :text, :meta_title,:meta_description
    scope :active, ->(){where(active: true)}
  end
end



