
module Content
  module EmailTemplateValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        multilang_attribute :text
        attribute :code, String
        validates :code, presence: true
        validate :title_multilang_presence
        validate :text_multilang_presence
      end
    end
    class Find
      include Validation::Base
      attribute :code
      attribute :with_layout, Boolean, default: false
      validates :code, presence: true
    end
  end
end


