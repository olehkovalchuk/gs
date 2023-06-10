# == Schema Information
#
# Table name: content_pages
#
#  id               :bigint           not null, primary key
#  active           :boolean          default(FALSE)
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
#  index_content_pages_on_active    (active)
#  index_content_pages_on_seo_name  (seo_name)
#
module Content
  class Page  < ApplicationRecord
    multilang :title, :text, :meta_title,:meta_description
    scope :active, ->(){where(active: true)}
  end
end



