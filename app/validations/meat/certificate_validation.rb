
module Meat
  module CertificateValidation
    class Base 
      include Validation::Base
      crudify do 
        multilang_attribute :title
        attribute :active, Boolean, default: false 
        attribute :logo, Hash
        validate :title_multilang_presence
        attribute :markets, Array[String]
        validates :markets, presence: true
      end
    end
  end
end

