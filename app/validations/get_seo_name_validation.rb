class GetSeoNameValidation
  include Validation::Base
  attribute :title, String
  attribute :klass, String
  validates :title, :klass, presence: true
end