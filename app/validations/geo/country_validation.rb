
module Geo
  module CountryValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        attribute :code, String
        attribute :region_code, String

        validates :code, :region_code, presence: true
        validates :code, uniqueness: true
        validate :title_multilang_presence

      end
    end
  end
end

