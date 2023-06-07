
module Order
  class Step  < ApplicationRecord
    multilang :title
    is_positionable
    belongs_to :proces, foreign_key: :process_id
  end
end



