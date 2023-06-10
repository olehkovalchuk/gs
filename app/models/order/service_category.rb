# == Schema Information
#
# Table name: order_service_categories
#
#  id         :bigint           not null, primary key
#  position   :integer
#  active     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :jsonb            not null
#
module Order
  class ServiceCategory  < ApplicationRecord
    has_many :service_items, foreign_key: :service_category_id, dependent: :delete_all
    scope :active, ->(){where(active: true)}
    is_positionable
    multilang :title

  end
end



