# == Schema Information
#
# Table name: delivery_packages
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  markets    :string           default(["\"meat\""]), not null, is an Array
#  title      :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_delivery_packages_on_active  (active)
#
module Delivery
  class Package  < ApplicationRecord
    multilang :title
    scope :active, ->(){where(active: true)}
  end
end



