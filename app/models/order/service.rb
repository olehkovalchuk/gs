
module Order
  class Service  < ApplicationRecord
    self.table_name = "offer_services"
    enum usage_type: {
      per_month: 'per_month',
      per_day: 'per_day',
      per_year: 'per_year',
      per_product: 'per_product',
      per_deal: 'per_deal',
    }
    multilang :title, :usage_title
    scope :active, ->(){where(active: true)}

    has_many :items,class_name: "::Order::Item", foreign_key: :service_id
  end
end



