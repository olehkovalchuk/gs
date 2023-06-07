
module Meat
  module InvoiceOperation
    class Base
      include Operation::Base
      crudify do
        model_name Invoice
      end
    end

    class FrontList < Base
      LIMIT = 15
      def perform
        conditions = form.current_user.is_company_owner ? {company_id: form.current_user.company_id } : {company_user_id: form.current_user.id }
        @model = Meat::Invoice.page(form.page).per(LIMIT).order(updated_at: :desc).where(conditions)
        @model.total_pages
      end
    end

    class Item < Read
      def perform
        add_error!(:access_denided, "Access denided") unless @model = form.current_user.company.invoices.find_by(id: form.id)
        @model
      end
    end

  end
end

