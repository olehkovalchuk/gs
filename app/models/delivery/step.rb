# == Schema Information
#
# Table name: delivery_steps
#
#  id              :bigint           not null, primary key
#  title           :jsonb            not null
#  delivery_code   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer          default(1), not null
#  seller_step     :boolean
#  buyer_step      :boolean
#  required_fields :jsonb            not null
#
module Delivery
  class Step  < ApplicationRecord
    multilang :title
    is_positionable
    has_and_belongs_to_many :step_fields, association_foreign_key: :field_id, foreign_key: :step_id, join_table: :delivery_steps_step_fields
    belongs_to :condition, foreign_key: :delivery_code, primary_key: :code

    def required_fields
      self.step_fields.map do |f|
        {
          title: f.title,
          field_type: f.field_type,
          id: f.id,
        }
      end
    end
  end
end
