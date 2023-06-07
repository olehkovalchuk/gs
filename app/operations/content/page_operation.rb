
module Content
  module PageOperation
    class Base
      include Operation::Base
      crudify do
        model_name Page
      end
    end

    class Get < Base
      def perform
        add_error!(:not_found, "not_found") unless @model = Content::Page.find_by(seo_name: form.seo_name)
        ::KibanaLogger.push("show_blog_page",{seo_name:form.seo_name})
        @model
      end
    end

  end
end

