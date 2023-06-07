
module Order
  class ServiceCategory  < ApplicationRecord
    has_many :service_items, foreign_key: :service_category_id, dependent: :delete_all
    scope :active, ->(){where(active: true)}
    is_positionable
    multilang :title

  end
end



