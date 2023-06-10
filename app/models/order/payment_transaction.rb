# == Schema Information
#
# Table name: order_payment_transactions
#
#  id              :bigint           not null, primary key
#  item_id         :integer          not null
#  status          :string           not null
#  description     :string           not null
#  amount          :float            not null
#  currency        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  item_type       :string           not null
#  company_id      :integer          not null
#  company_user_id :string           not null
#  system          :string           not null
#  system_id       :string
#  token           :string           not null
#
module Order
  class PaymentTransaction  < ApplicationRecord
    belongs_to :company, class_name: "::Meat::Company", foreign_key: :company_id
    # belongs_to :service, class_name: "::Order::Service", foreign_key: :item_id
    belongs_to :company_user, class_name: "::Meat::CompanyUser", foreign_key: :company_user_id
    delegate :title, to: :company, prefix: true
    delegate :title, to: :company_user, prefix: true


    enum status: {
      failed: 'failed',
      created: 'created',
      cancelled: 'cancelled',
      payed: 'payed',
      completed: 'completed',
    }

    enum item_type: {
      safe_deal: 'safe_deal',
      verification: 'verification',
      usage_fee: 'usage_fee',
      forward: 'forward',
      secure: 'secure',
      package: 'package'

    }

  end
end



