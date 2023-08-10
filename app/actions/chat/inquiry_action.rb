
module Chat
  module InquiryAction
    extend self

    def after_update(model,form)
      model.edited!
    end

    def after_create(model,form)
      # disabled inquiry emails for all users
      return
      # return if model.recipient.reset_password_token.presence

      model.update(inquiry_email: "inquiries+#{Digest::MD5.hexdigest(model.id.to_s)}@globsupplies.com")
      if form.with_recount && !model.recipient_company.presenter.allowed_to_use?(:received_inquries)
        model.unpayed!
        UserMailer.notify( model.recipient, I18n.t("common.you_have_unpayed_inquiry", from: model.title), I18n.t("common.please_paid_inqury") ).send(Rails.env.development? ? :deliver_now : :deliver_later )
        return
      end
      Meat::CompanyAction.update_limits(model.recipient_company, :received_inquries)
      true
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