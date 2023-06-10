# == Schema Information
#
# Table name: chat_contacts
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Chat
  class Contact  < ApplicationRecord

  end
end



