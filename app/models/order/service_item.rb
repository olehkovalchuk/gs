# == Schema Information
#
# Table name: order_service_items
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(FALSE), not null
#  position            :integer
#  title               :jsonb            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  service_category_id :integer          not null
#
# Indexes
#
#  index_order_service_items_on_service_category_id  (service_category_id)
#
module Order
  class ServiceItem  < ApplicationRecord
    belongs_to :service_category, foreign_key: :service_category_id, class_name: "::Order::ServiceCategory"
    delegate :title, to: :service_category, prefix: true
    scope :active, ->(){where(active: true)}
    is_positionable
    multilang :title

  end
end



