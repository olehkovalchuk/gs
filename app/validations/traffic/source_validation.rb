
module Traffic
  module SourceValidation
    class Base 
      include Validation::Base
      crudify do 
        attribute :name, String
        validates :name, presence: true
      end
    end
  end
end

