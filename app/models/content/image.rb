# == Schema Information
#
# Table name: content_images
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Content
  class Image  < ApplicationRecord
    has_one_attached :file
  end
end



