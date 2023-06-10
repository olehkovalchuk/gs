# == Schema Information
#
# Table name: delivery_step_fields
#
#  id         :bigint           not null, primary key
#  title      :jsonb            not null
#  field_type :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Delivery
  class StepField  < ApplicationRecord
    multilang :title
    enum field_type: {
      string: "string",
      date: "date",
      file: "file"
    }
    has_and_belongs_to_many :steps, association_foreign_key: :step_id , foreign_key: :field_id

  end
end



