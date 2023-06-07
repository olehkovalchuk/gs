
module Content
  module SeoPageOperation
    class Base
      include Operation::Base
      crudify do
        model_name SeoPage
      end
    end

    class Generate < Base
      def perform
        Content::SeoPage.marketplace_types.values.each do |t|
          ::Geo::Country.pluck(:code).each do |code|
            ::Content::SeoPage.find_or_initialize_by( marketplace_type: t, page_type: "country", country_code: code ).save!
            ::Meat::Category.pluck(:seo_name).each do |id|
              ::Content::SeoPage.find_or_initialize_by( marketplace_type: t, page_type: "country_category", country_code: code, category_seo: id ).save!
              ::Content::SeoPage.find_or_initialize_by( marketplace_type: t, page_type: "category", category_seo: id ).save!
            end
          end
        end
      end
    end

    class Get < Base
      attr_reader :text, :title, :description, :meta_title, :id
      def perform
        @model = if form.country_code.presence && form.category_seo.presence
          Content::SeoPage.country_category.find_by( marketplace_type: form.marketplace_type, country_code: form.country_code, category_seo: form.category_seo )
        elsif form.country_code.presence
          Content::SeoPage.country.find_by( marketplace_type: form.marketplace_type, country_code: form.country_code )
        elsif form.category_seo.presence
          Content::SeoPage.category.find_by( marketplace_type: form.marketplace_type, category_seo: form.category_seo )
        end
        add_error!(:not_found, "not_found") unless @model

        @text = @model.has_own_text ?  @model.text :  _get_default(:text)
        @title = @model.has_own_text ? @model.meta_title : _get_default(:heading)
        @description = @model.has_own_text ? @model.meta_description : _get_default(:description)
        @meta_title =  @model.has_own_text ? @model.meta_title : _get_default(:title)
        @id = ::Meat::Category.select(:id).find_by(seo_name: form.category_seo).id if form.category_seo.presence
        @model
      end

      private

      def _get_default( type )
        placeholders = {
          country_title: @model.country_title,
          category_title: @model.category_title
        }
        I18n.t("seo_text.#{type}.#{form.marketplace_type}.#{@model.page_type}",placeholders)
      end
    end

  end
end
