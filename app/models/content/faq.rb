# == Schema Information
#
# Table name: content_faqs
#
#  id               :bigint           not null, primary key
#  active           :boolean          default(FALSE)
#  category         :string           not null
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
#  index_content_faqs_on_active    (active)
#  index_content_faqs_on_category  (category)
#  index_content_faqs_on_seo_name  (seo_name)
#
module Content
  class Faq  < ApplicationRecord
    multilang :title, :text
    scope :active, ->(){where(active: true)}
  end
end



