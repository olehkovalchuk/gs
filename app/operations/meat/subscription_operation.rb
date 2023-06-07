
module Meat
  module SubscriptionOperation
    class Base
      include Operation::Base
      crudify do
        model_name Subscription
      end
    end

    class Send
      def perform
        # Meat::Subscription.all.each do |item|
        #   items = "::Meat::#{item.type.capitalize}".constantize
        #     .where(category_id: item.category_ids)
        #     .where("updated_at > :time", time: Time.now - 2.days )
        #     .where.not(company_id: item.company_id)
        #     .order(updated_at: :desc)
        #     .limit(5)
        #   ::UserMailer.subscription(item.company_user, items).send(Rails.env.development? ? :deliver_now : :deliver_later ) if items.any?
        # end


        ::Meat::Request.active.where(subscribe: true).all.group_by{|i| i.category_id }.each_pair do |id,requests|
          items = ::Meat::Offer.active
            .where(category_id: id)
            .where("updated_at > :time", time: Time.now - 2.days )
            .order(updated_at: :desc)
            .limit(5)
          requests.uniq_by(&:company_user_id).each do |item|
            ::UserMailer.subscription(item.company_user, items).send(Rails.env.development? ? :deliver_now : :deliver_later ) if items.any?
          end
        end

      end
    end
  end
end
