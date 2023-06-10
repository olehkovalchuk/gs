# == Schema Information
#
# Table name: order_files
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  process_id        :integer
#  document_id       :integer
#  sender_id         :integer          not null
#  sender_company_id :integer          not null
#
module Order
  class File  < ApplicationRecord
    has_one_attached :attachment
  end
end



