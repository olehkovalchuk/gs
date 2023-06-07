
module Order
  module ProcesAction
    extend self


    def after_create model, form
      create_notification(model,form,I18n.t("common.submited_new_po"))
    end

    def after_buyer_update model, form
      create_notification(model,form,I18n.t("common.updated_po"))
    end

    def after_seller_update model, form
      create_notification(model,form,I18n.t("common.confirmed_new_po"))
    end

    def after_seller_upload model, form
      create_notification(model,form,I18n.t("common.uploaded_signed_documents"))
    end

    def after_buyer_upload model, form
      create_notification(model,form,I18n.t("common.uploaded_signed_documents"))
    end

    def after_buyer_complain model, form
      create_notification(model,form,I18n.t("common.start_complain_the_po"))
    end

    def after_buyer_cancel model, form
      create_notification(model,form,I18n.t("common.cancelled_the_po"))
    end

    def after_seller_complain model, form
      create_notification(model,form,I18n.t("common.start_complain_the_po"))
    end

    def after_seller_cancel model, form
      create_notification(model,form,I18n.t("common.cancelled_the_po"))
    end

    def after_seller_sign model, form
      create_notification(model,form,I18n.t("common.confirmed_sign_po"))
    end

    def after_buyer_sign model, form
      create_notification(model,form,I18n.t("common.confirmed_sign_po"))
    end

    def after_buyer_add_files model, form
      create_notification(model,form,I18n.t("common.added_po_files"))
    end

    def after_seller_add_files model, form
      create_notification(model,form,I18n.t("common.added_po_files"))
    end

    def after_step_completed model, form, step
      create_notification(model,form,I18n.t("common.step_completed", step: step.title))
      if model.steps.map(&:completed).all?
        model.completed!
        model.finished!
      end
    end

    def on_step_data_added model, form, step, id, val
      if step.required_fields.any?
        create_notification(model,form,I18n.t("common.step_updated", field: step.required_fields.find{|f| f["id"].to_i == id.to_i}["title"], value: val))
      else
        create_notification( model, form, I18n.t( "common.step_completed_many" ) )
      end
    end

    private

    def create_notification(model,form,text)
      ::Chat::NotificationOperation::Create.new(
        sender_company_id: form.current_user.company_id,
        sender_company_user_id: form.current_user.id,
        recipient_company_id: model.recipient_company_id,
        recipient_company_user_id: model.recipient_company_user_id,
        comment: text,
        notificable_id: model.id,
        notificable_type: model.class.name,
        action: "process",
        item_type: "process",
        params: {id: model.process_id}
      ).process
    end

    # Available callbacks methods
    # after_save
    # before_save
    # after_create
    # before_create
    # after_destroy
    # before_destroy
    # after_update
    # before_update
  end
end



