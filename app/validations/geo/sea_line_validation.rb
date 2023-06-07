
module Geo
  module SeaLineValidation
    class Base 
      include Validation::Base
      crudify do 
        attribute :title, String
        attribute :active, Boolean, default: false
        validates :title, presence: true
      end
    end
  end
end

