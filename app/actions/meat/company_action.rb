
module Meat
  module CompanyAction
    extend self
    def before_save(model,form)
      model.seo_name = ::GetSeoNameOperation.(klass: "Meat::Company", title: model.title) if model.seo_name.blank?
    
      if model.moderated && !form.moderated 
        ::Admin::User.all.each do |user|
          ::Admin::UserMailer.notify( "Need to moderate company §#{model.title}§", "Need to moderate company §#{model.title}§", user ).send(Rails.env.development? ? :deliver_now : :deliver_later )
        end
      elsif form.moderated && !model.moderated
        Meat::CompanyOperation::CalculateRating.new(id: form.id ).process if form.respond_to?(:id)
      end
    end

    def after_doc_attached model, form 
      ::Admin::User.all.each do |user|
        ::Admin::UserMailer.notify( "#{model.title} attach document to review", "#{model.title} attach document to review", user ).send(Rails.env.development? ? :deliver_now : :deliver_later )
      end
    end

    def after_create model, form
      # ::Chat::ConversationOperation::CreateDefault.new(company: model).process
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

    def after_member_add(model,form)
      model.increment!(:managers_count, 1)
    end

    def update_limits(model, type, skip_notification = false)

      model.increment!("#{type}_used")
      model.reload

      default_company = ::Meat::Company.find(::Setting.get("admin_company_id"))
      default_user = default_company.managers.first
      return true if skip_notification

      limits_left = model.send("#{type}_used") - model.send("#{type}_limit")
      
      message_type = limits_left.zero? ? 'zero' : limits_left > 1 ? 'many' : 'one'

      message = [I18n.t("common.notifications_messages.#{type}.heading")]

      message << I18n.t("common.notifications_messages.#{type}.text.#{message_type}")

      message << I18n.t("common.notifications_messages.#{type}.footer")

      ::Chat::NotificationOperation::Create.new(
        sender_company_id: default_company.id,
        sender_company_user_id: default_user.id,
        recipient_company_id: model.id,
        recipient_company_user_id: model.managers[0].id,
        comment: message.join('<br>'),
        notificable_id: model.id,
        notificable_type: model.class.name,
        action: "pricing",
        item_type: :pricing,
        params: {path: 'pricing'}
      ).process

      # ::Chat::NotificationOperation::Create.new(
      #   sender_company_id: default_company.id,
      #   sender_company_user_id: default_user.id,
      #   recipient_company_id: model.id,
      #   recipient_company_user_id: model.managers[0].id,
      #   comment: "You have reached your maximum #{I18n.t("common.packages.#{type}")} count. Update your membership to get more!",
      #   notificable_id: model.id,
      #   notificable_type: model.class.name,
      #   action: "pricing",
      #   item_type: :pricing,
      #   params: {path: 'pricing'}
      # ).process if  model.send("#{type}_used") == model.send("#{type}_limit")

      true
    end

  end
end
