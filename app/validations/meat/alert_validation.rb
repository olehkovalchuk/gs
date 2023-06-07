
module Meat
  module AlertValidation
    class Base
      include Validation::Base
      crudify do
        attribute :category_id, Integer
        attribute :current_user, Meat::CompanyUserPresenter
        validates :current_user, :category_id,  presence: true
      end
    end
  end
end
