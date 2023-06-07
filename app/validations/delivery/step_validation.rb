
module Delivery
  module StepValidation
    class Base
      include Validation::Base
      crudify with: [:habtm, :habtm_update, :history] do
        multilang_attribute :title
        attribute :position, Integer
        attribute :seller_step, Boolean ,default: false
        attribute :buyer_step, Boolean ,default: false
        attribute :delivery_code, String
        validates :delivery_code, presence: true
        validate :title_multilang_presence

      end
    end
  end
end
