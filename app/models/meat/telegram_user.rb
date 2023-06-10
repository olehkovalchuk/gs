# == Schema Information
#
# Table name: meat_telegram_users
#
#  id          :bigint           not null, primary key
#  telegram_id :integer          not null
#  name        :string           not null
#  category_id :integer
#  locale      :string           default("en"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module Meat
  class TelegramUser  < ApplicationRecord

  end
end



