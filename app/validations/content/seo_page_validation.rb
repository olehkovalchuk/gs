
module Content
  module SeoPageValidation
    class Base
      include Validation::Base
      crudify do
        attribute :country_code, String
        attribute :page_type, String
        attribute :category_seo, String
        attribute :marketplace_type, String, default: "sell"
        attribute :has_own_text, Boolean, default: false

        multilang_attribute :text
        multilang_attribute :meta_title
        multilang_attribute :meta_description

        validate :text_multilang_presence, if: ->(o){o.has_own_text}
        validate :meta_title_multilang_presence, if: ->(o){o.has_own_text}
        validate :meta_description_multilang_presence, if: ->(o){o.has_own_text}

        validates :page_type, :marketplace_type, presence: true
      end
    end

    class Get
      include Validation::Base
      attribute :country_code, String
      attribute :category_seo, String
      attribute :marketplace_type, String

      validates :country_code, presence: true, unless: ->(o){o.category_seo.presence}
      validates :category_seo, presence: true,unless: ->(o){o.country_code.presence}
      validates :marketplace_type, presence: true
    end

    class Generate
      include Validation::Base
    end
  end
end

