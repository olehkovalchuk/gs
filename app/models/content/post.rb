
module Content
  class Post  < ApplicationRecord
    multilang :title, :text, :meta_title,:meta_description, :anons
    scope :active, ->(){where(active: true)}
    has_one_attached :image
  end
end



