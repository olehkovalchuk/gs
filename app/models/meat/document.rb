# == Schema Information
#
# Table name: meat_documents
#
#  id               :bigint           not null, primary key
#  active           :boolean          default(TRUE)
#  active_for_offer :boolean          default(TRUE)
#  active_for_po    :boolean          default(TRUE)
#  markets          :string           default(["\"meat\""]), not null, is an Array
#  need_before_sign :boolean
#  need_sign        :boolean          default(FALSE)
#  template         :string
#  title            :jsonb            not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_meat_documents_on_active  (active)
#
module Meat
  class Document  < ApplicationRecord
    multilang :title
    scope :active_for_offer, ->(){where(active_for_offer: true)}
    scope :active_for_po, ->(){where(active_for_po: true)}
    scope :need_sign, ->(){where(need_sign: true)}
  end
end
