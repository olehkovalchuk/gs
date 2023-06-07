
module Meat
  module SortingValidation
    class Base
      include Validation::Base
      AVAILABLE_SORT_KEYS = ["updated_at","created_at","rating","price"]
      AVAILABLE_SORT_DIR = ["asc","desc"]

      include Validation::Base
      attribute :direction, String, default: "DESC"
      attribute :field, String, default: "created_at"

      before_validation do |params|
        params.field.downcase!
        params.direction.downcase!
      end

      validates :field, inclusion: { in: AVAILABLE_SORT_KEYS }
      validates :direction, inclusion: { in: AVAILABLE_SORT_DIR }
    end
  end
end

