
module Order
  module PaymentTransactionAction
    extend self

    # Available callbacks methods
    # after_save
    # before_save
    # after_create
    # before_create
    # after_destroy
    # before_destroy
    # after_update
    # before_update

    def after_destroy model
      clear_cache model
    end

    def update_company model, payment
      if payment.payed?
        %w[offers_count requests_count received_inquries replyies_to_inquries active_chats show_infos buyer_allerts sended_inquries top_offers].each do |field|
          payment.company.update( "#{field}_limit" => (payment.company.send("#{field}_limit") - payment.company.send("#{field}_used")) + model.send(field).to_i )
          payment.company.update( "#{field}_used" => 0)
        end
        payment.company.update(sub_accounts_limit: model.sub_accounts )
        payment.company.update(rating_code: model.rating_code )
        payment.company.update(on_map: model.map_access )
      end
    end

    # def clear_cache model, form = nil
    #   if model.payed? && form
    #     used_ininquies_count = model.company.used_ininquies_count - 3
    #     used_ininquies_count = used_ininquies_count < 1 ? 0 : used_ininquies_count
    #     model.company.update(used_ininquies_count: used_ininquies_count)
    #   end
    #   Rails.cache.clear "has_payed_subscription_#{model.company_id}"
    # end
  end
end

