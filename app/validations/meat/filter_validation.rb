
module Meat
  module FilterValidation
    class Base
      include Validation::Base

      PRICE_MIN = 0
      PRICE_MAX = 100_000

      attribute :origins, Array[String], default: []
      attribute :ids, Array[Integer], default: []
      attribute :delivery, Array[String], default: []
      attribute :payment_types, Array[String], default: []
      attribute :permissions, Array[String], default: []
      attribute :prices, Array, default: [PRICE_MIN,PRICE_MAX]
      attribute :title, String
      attribute :active
      attribute :id, Integer, default: 0

      attribute :category_id, Integer, default: 0
      attribute :category_seo, String



      before_validation do |form|
        form.origins = form.origins.reject(&:blank?).uniq
        form.delivery = form.delivery.reject(&:blank?).uniq
        form.payment_types = form.payment_types.reject(&:blank?).uniq
        form.permissions = form.permissions.reject(&:blank?).uniq
        form.prices = [] if (form.prices - [PRICE_MIN,PRICE_MAX]).empty?
      end

    end
  end
end

