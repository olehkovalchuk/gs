
module Content
  module FaqValidation
    class Base 
      include Validation::Base
      crudify do 
        attribute :category, String
        attribute :with_layout, Boolean, default: true
        attribute :active, Boolean, default: false
        multilang_attribute :title
        multilang_attribute :text
        validate :title_multilang_presence
        validate :text_multilang_presence
        validates :category, presence: true
      end
    end

    class FrontList
      include Validation::Base
    end
  end
end

