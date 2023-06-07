
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



