# == Schema Information
#
# Table name: content_posts
#
#  id               :bigint           not null, primary key
#  active           :boolean          default(FALSE)
#  anons            :jsonb            not null
#  meta_description :jsonb            not null
#  meta_title       :jsonb            not null
#  seo_name         :string           not null
#  text             :jsonb            not null
#  title            :jsonb            not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_content_posts_on_active    (active)
#  index_content_posts_on_seo_name  (seo_name)
#
module Content
  class Post  < ApplicationRecord
    multilang :title, :text, :meta_title,:meta_description, :anons
    scope :active, ->(){where(active: true)}
    has_one_attached :image
  end
end



