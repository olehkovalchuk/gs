class SubscriberReport
  include Report::Base
  class << self
    def get_default_fields
      ["email"]
    end
  end
end
