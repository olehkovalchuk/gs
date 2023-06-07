
module Chat
  module FeedbackValidation
    class Base
      include Validation::Base
      crudify do
        attribute :text, String
        validates :text, presence: true
      end
    end
  end
end

