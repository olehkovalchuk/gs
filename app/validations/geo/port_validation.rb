
module Geo
  module PortValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        attribute :code, String
        attribute :country_code, String
        attribute :active, Boolean, default: false 

        attribute :latitude, Float
        attribute :longitude, Float

        validates :code, :country_code, presence: true
        validate :title_multilang_presence
        validates :code, uniqueness: true

      end
    end
  end
end

