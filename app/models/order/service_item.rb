
module Order
  class ServiceItem  < ApplicationRecord
    belongs_to :service_category, foreign_key: :service_category_id, class_name: "::Order::ServiceCategory"
    delegate :title, to: :service_category, prefix: true
    scope :active, ->(){where(active: true)}
    is_positionable
    multilang :title

  end
end



