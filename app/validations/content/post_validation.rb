module Content
  module PostValidation
    class Base
      include Validation::Base
      crudify do
        multilang_attribute :title
        multilang_attribute :text
        multilang_attribute :meta_title
        multilang_attribute :meta_description
        multilang_attribute :anons
        attribute :seo_name, String
        attribute :image
        attribute :active, Boolean, default: false
        validates :seo_name, presence: true
        validate :title_multilang_presence
        validate :anons_multilang_presence
        validate :text_multilang_presence
      end
    end
    class Get
      include Validation::Base
      attribute :seo_name
      validates :seo_name, presence: true
    end
  end
end

