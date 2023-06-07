
module Chat
  module ContactValidation
    class Base 
      include Validation::Base
      crudify do 
        attribute :email, String
        attribute :name, String
        attribute :text, String
        validates :email, :name, :text, presence: true
      end
    end
  end
end
