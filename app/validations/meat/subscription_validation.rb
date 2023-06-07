
module Meat
  module SubscriptionValidation
    class Base
      include Validation::Base
      crudify do
        attribute :category_ids, Array[Integer]
        attribute :company_id, Integer
        attribute :company_user_id, Integer
        attribute :type, String

        validates :category_ids, :company_id, :company_user_id, presence: true
        validates :type, inclusion: { in: ["offer","request"] }
      end
    end
  end
end

