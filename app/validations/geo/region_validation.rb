
module Geo
  module RegionValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        attribute :code, String
        validates :code, presence: true
        validates :code, uniqueness: true
        validate :title_multilang_presence

      end
    end
    class FilterTree 
      include Validation::Base
      attribute :active_type, String
      validates :active_type, presence: true
      
    end
  end
end

