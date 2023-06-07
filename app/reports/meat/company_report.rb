module Meat
  class CompanyReport
    include Report::Base
    class << self
      def get_default_fields
        ["title"]
      end
    end
  end
end
