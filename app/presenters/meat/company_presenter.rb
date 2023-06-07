module Meat
  class CompanyPresenter < BasePresenter
    def next_status
      availables = Meat::Company.rating_codes.values
      current_index = availables.index(@object.rating_code)
      current_index < availables.count ? availables[ current_index + 1 ] : nil
    end

    def points_left
      points =  self.next_status ? Meat::Company::RATINGS[self.next_status.to_sym].to_i - @object.rating : 0
      points > 0 ? points : 0
    end

    def can_add_member?
      true
    end

    def certificates
      Meat::Certificate.where(id: @object.certificates )
    end

    def bill_on_review
      @object.bill.attached? && !@object.bill_verified
    end
    def passport_on_review
      @object.passport.attached? && !@object.pasport_verified
    end

    def kibana_data
      {
        company_name: @object.title
      }
    end

    def allowed_to_use?(type)
      @object.package_expiration >= Date.current && @object.send("#{type}_limit") - @object.send("#{type}_used") > 0
    end
    def title_formated( user = nil )
      return "in #{@object.country.title}" if user.kind_of?(TrueClass)
      return I18n.t("common.company_title", title: @object.title, id: @object.id ).html_safe if @object.id == ::Setting.get("admin_company_id").to_i || (user && @object.id == user.company_id)
      return I18n.t("common.login_to_see_company_name").html_safe unless user
      return I18n.t("common.company_title", title: @object.managers.first&.presenter&.full_title, id: @object.id ).html_safe
    end


  end
end
