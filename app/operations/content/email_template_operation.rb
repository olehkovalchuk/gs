module Content
  module EmailTemplateOperation
    class Base
      include Operation::Base
      crudify do
        model_name EmailTemplate
      end
    end

    class Find < Base
      def perform

        unless @model = Content::EmailTemplate.find_by(code: form.code)
          html = ::ApplicationController.render template: "email/#{form.code}", layout: form.with_layout ? 'mailer' : false
          @model = Content::EmailTemplate.create!(
            code: form.code,
            text: I18n.available_locales.inject({}){|hash,l| hash.merge!(l=>html) },
            title: I18n.available_locales.inject({}){|hash,l| I18n.t("common.emails.#{form.code}", locale: l) }
          )
        end
        @model
      end
    end

  end
end





