module Meat
  class CompanyUserPresenter < BasePresenter
    def is_company_owner?
      true
    end

    def full_title
      "#{first_name.capitalize} from #{@object.country.title}"
    end

    def can_add_member?
      @object.is_company_owner && @object.company.managers.count <=6
    end


    def user_name
      "#{@object.first_name} #{@object.last_name}"
    end

    def can_start_safe_deal?
      @object.company.payment_transactions.safe_deal.payed.first
    end


    def allowed_to_use?(type)
      @object.company.presenter.allowed_to_use?(type)
    end

    def has_payed_subscription?
      Rails.cache.fetch("has_payed_subscription_#{@object.company_id}", expire_in: 1.hour) do
        @object.company.payment_transactions.usage_fee.payed.any? do |transaction|
          transaction.created_at + transaction.service.presenter.usage_period > Time.zone.now
        end
      end
    end

  end
end
