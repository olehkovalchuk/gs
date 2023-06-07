module Order
  module ServiceValidation
    class Base
      include Validation::Base
      crudify do
        attribute :usage_type, String
        attribute :usage_period, Integer
        attribute :active, Boolean
        attribute :code, String
        attribute :price, Float
        attribute :old_price, Float
        multilang_attribute :title
        multilang_attribute :usage_title



        validates :usage_type,:usage_period,:code,:price,  presence: true
        validate :title_multilang_presence
        # validate :usage_title_multilang_presence
      end
    end

    class Pay < Read
      attribute :current_user, Meat::CompanyUserPresenter
      # validates :current_user, presence: true
    end
  end
end
