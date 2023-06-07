
module Order
  class Package  < ApplicationRecord
    scope :active, ->(){where(active: true)}

    has_many :items,class_name: "::Order::Item", foreign_key: :service_id
    # has_many :service_items, class_name: "::Order::PackageService"

    has_one_attached :file
    is_positionable


    multilang :title

  end
end



