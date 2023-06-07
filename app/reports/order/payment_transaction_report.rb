module Order
  class PaymentTransactionReport
    include Report::Base
    class << self
      def get_default_fields
        ["status"]
      end
    end
  end
end
