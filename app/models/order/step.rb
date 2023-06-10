# == Schema Information
#
# Table name: order_steps
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer          not null
#  title           :jsonb            not null
#  completed       :boolean          default(FALSE)
#  seller_step     :boolean          default(TRUE)
#  required_fields :jsonb            not null
#  completed_at    :datetime
#  buyer_step      :boolean
#  process_id      :integer          not null
#
module Order
  class Step  < ApplicationRecord
    multilang :title
    is_positionable
    belongs_to :proces, foreign_key: :process_id
  end
end



