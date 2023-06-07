
module Meat
  module BidAction
    extend self

    def after_create( model, form )
      model.sender_company.increment!(:bids_out_count)
      model.sender.increment!(:bids_out_count)
      model.recipient_company.increment!(:bids_in_count)
      model.recipient.increment!(:bids_in_count)



      ::Chat::NotificationOperation::Create.new(
        sender_company_id: form.current_user.company_id,
        sender_company_user_id: form.current_user.id,
        recipient_company_id: model.recipient_company_id,
        recipient_company_user_id: model.recipient_company_user_id,
        comment: I18n.t("common.new_bid"),
        notificable_id: model.bidable.id,
        notificable_type: model.bidable.class.name,
        action: "cabinet-offer",
        item_type: model.bidable.class.name.split("::").last.downcase,
        params: {id: model.bidable.id}
      ).process

      UserMailer.new_bid( model.recipient, model ).send(Rails.env.development? ? :deliver_now : :deliver_later )

      ::WhatsappSender.call(
        I18n.t('common.whatsapp.new_bid', {
          link: "https://globsupplies.com/marketplace/#{model.bidable.class.name.split('::').last.downcase}/#{model.bidable.id}",
          title: model.bidable.category_title,
          username: model.recipient.presenter.user_name
        }),
        model.recipient.phone
      )
    end

    def after_destroy( model )
      model.sender_company.decrement!(:bids_out_count)
      model.sender.decrement!(:bids_out_count)
      model.recipient_company.decrement!(:bids_in_count)
      model.recipient.decrement!(:bids_in_count)
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


