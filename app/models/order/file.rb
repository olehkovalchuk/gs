
module Order
  class File  < ApplicationRecord
    has_one_attached :attachment
  end
end



