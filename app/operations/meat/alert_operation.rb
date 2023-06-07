
module Meat
  module AlertOperation
    class Base
      include Operation::Base
      crudify do
        model_name Alert
      end
    end


    class Create
      include Operation::Base
      def perform
        add_error!(:not_allowed, 'You have reached your limit of alerts. To get more limmits, upgrade your membership') unless form.current_user.allowed_to_use?(:buyer_allerts)
        ::KibanaLogger.push("alert", {category_id: form.category_id} )

        Meat::Alert.create(category_id: form.category_id, company_id: form.current_user.company_id)
        Meat::CompanyAction.update_limits(form.current_user.company, :buyer_allerts)
        true
      end
    end

  end
end
