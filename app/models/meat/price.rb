# == Schema Information
#
# Table name: meat_prices
#
#  id    :bigint           not null, primary key
#  key   :string           not null
#  value :float            default([]), not null, is an Array
#
module Meat
  class Price  < ApplicationRecord

  end
end



