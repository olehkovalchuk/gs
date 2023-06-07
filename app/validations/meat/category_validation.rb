
module Meat
  module CategoryValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        attribute :icon, String
        attribute :cls, String
        attribute :parent_id, Integer
        attribute :active, Boolean, default: false 
        attribute :image
        attribute :market

        validates :parent_id, :market, presence: true
        validate :title_multilang_presence
        validates :icon, :cls, presence: true, if: ->(o){o.parent_id.zero?}
      end
    end

    class FindBySeo
      include Validation::Base
      attribute :seo
      validates :seo, presence: true
    end
  end
end

