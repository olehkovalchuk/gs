# == Schema Information
#
# Table name: order_packages
#
#  id                   :bigint           not null, primary key
#  price                :float            default(0.0), not null
#  description          :string           not null
#  offers_count         :integer          default(0), not null
#  requests_count       :integer          default(0), not null
#  received_inquries    :integer          default(0), not null
#  replyies_to_inquries :integer          default(0), not null
#  map_access           :boolean          default(FALSE), not null
#  is_best              :boolean          default(FALSE), not null
#  active               :boolean          default(TRUE), not null
#  active_chats         :integer          default(0), not null
#  show_infos           :integer          default(0), not null
#  buyer_allerts        :integer          default(0), not null
#  sub_accounts         :integer          default(0), not null
#  rating_code          :string           default("fresh"), not null
#  currency             :string           default("USD"), not null
#  offline_packages     :jsonb            not null
#  performance          :string           default(""), not null
#  reports              :string           default(""), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  position             :integer
#  sended_inquries      :integer          default(0), not null
#  top_offers           :integer          default(0), not null
#  default              :boolean          default(FALSE), not null
#  title                :jsonb            not null
#  days                 :integer          default(30), not null
#
module Order
  class Package  < ApplicationRecord
    scope :active, ->(){where(active: true)}

    has_many :items,class_name: "::Order::Item", foreign_key: :service_id
    # has_many :service_items, class_name: "::Order::PackageService"

    has_one_attached :file
    is_positionable


    multilang :title

  end
end



