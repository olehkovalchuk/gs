# == Schema Information
#
# Table name: order_items
#
#  id          :bigint           not null, primary key
#  is_included :boolean          default(TRUE)
#  title       :jsonb            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  service_id  :integer          not null
#
# Indexes
#
#  index_order_items_on_service_id  (service_id)
#
module Order
  class Item  < ApplicationRecord
     multilang :title
  end
end



