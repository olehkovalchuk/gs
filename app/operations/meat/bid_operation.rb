
module Meat
  module BidOperation
    class Base
      include Operation::Base
      crudify do
        model_name Bid
      end
    end

    class FrontList < Base
      LIMIT = 15
      def perform
        conditions = form.current_user.is_company_owner ? {sender_company_id: form.current_user.company_id } : {sender_company_user_id: form.current_user.id }
        @model = Meat::Bid.page(form.page).per(LIMIT).order(updated_at: :desc).where(conditions)
        total = @model.total_pages
        @model = @model.all.select(&:bidable)
        total
      end
    end

    class DestroyWithAuth < Read 
      def perform 
        add_error!(:cant_delete_this_bid, "Cant delete this bid") unless form.current_user.company_id == @model.sender_company_id
        with_transaction do
          old_model = model.dup
          add_error!(:undeletable, "Model cant be deleted") if model.respond_to?(:undeletable) && model.undeletable
          trigger :before_destroy, model
          begin
            result = model.respond_to?(:deleted) ? model.update(deleted: true) : model.destroy!
          rescue ActiveRecord::RecordNotDestroyed => e
            add_error!(:cant_destroy,"Cant be destoyed")
          end

          trigger :after_destroy, old_model

          result
        end
      end
    end

  end
end

