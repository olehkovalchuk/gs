# == Schema Information
#
# Table name: offer_services
#
#  id           :bigint           not null, primary key
#  title        :jsonb            not null
#  code         :string           not null
#  price        :float            not null
#  old_price    :float
#  usage_period :integer
#  usage_type   :string
#  usage_title  :jsonb            not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  active       :boolean          default(TRUE)
#  deleted      :boolean          default(FALSE)
#  currency     :string           default("USD"), not null
#
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



