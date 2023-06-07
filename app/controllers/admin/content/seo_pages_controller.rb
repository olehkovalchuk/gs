module Admin

    module Content
      class SeoPagesController < Admin::ApplicationController
        work_with model: "::Content::SeoPage" do
          on_collection :generate_missing
        end

        include Admin::FormHelper

        def generate_missing
          process_and_respond!(operation: ::Content::SeoPageOperation::Generate.new ) do |operation, result|
            render json: {success: true}
          end
        end

        def _prepare_form_data
          {
            page_types: ::Content::SeoPage.page_types.keys.map{|i| {id: i, title: i} },
            marketplace_types: ::Content::SeoPage.marketplace_types.keys.map{|i| {id: i, title: i} },
            countries: ::Geo::Country.pluck(:code,"title->'#{I18n.locale}'").map{|i| {id: i[0], title: i[1]} },
            categories: form_choose.concat( ::Meat::Category.pluck(:seo_name,"title->'#{I18n.locale}'").map{|i| {id: i[0], title: i[1]} })
          }
        end

        def _setup_filter_variables
          @categories = ::Meat::Category.order("title->'#{I18n.locale}' ASC").pluck("title->'#{I18n.locale}'",:seo_name)
          @countries = ::Geo::Country.order("title->'#{I18n.locale}' ASC").pluck("title->'#{I18n.locale}'",:id)
          @page_types = ::Content::SeoPage.page_types.keys
        end


      end
    end

end

