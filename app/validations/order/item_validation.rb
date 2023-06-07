
module Order
  module ItemValidation
    class Base
      include Validation::Base
      crudify do
        attribute :service_id, Integer
        attribute :is_included, Boolean, default: true
        multilang_attribute :title
        validate :title_multilang_presence
        validates :service_id, presence: true
      end
    end
  end
end

