# == Schema Information
#
# Table name: meat_categories
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(TRUE)
#  active_for_offers   :boolean          default(FALSE)
#  active_for_requests :boolean          default(FALSE)
#  cls                 :string
#  icon                :string
#  market              :string           default("meat"), not null
#  offers_count        :integer          default(0), not null
#  path                :ltree
#  position            :integer          default(0)
#  requests_count      :integer          default(0), not null
#  seo_name            :string           not null
#  title               :jsonb            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  parent_id           :integer          default(0), not null
#
# Indexes
#
#  index_meat_categories_on_active     (active)
#  index_meat_categories_on_parent_id  (parent_id)
#
module Meat
  module CategorySerializer
    class Main < ActiveModel::Serializer
      attributes :id,:title
    end
  end
end
