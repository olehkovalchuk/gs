# == Schema Information
#
# Table name: meat_certificates
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
#  index_meat_certificates_on_active  (active)
#
module Meat
  class Certificate  < ApplicationRecord
    multilang :title
    has_one_attached :logo
    scope :active, ->(){where(active: true)}
  end
end



