SitemapGenerator::Sitemap.default_host = "https://globsupplies.com"
SitemapGenerator::Sitemap.namer = SitemapGenerator::SimpleNamer.new(:sitemap, extension: '.xml')
SitemapGenerator::Sitemap.create do

  I18n.available_locales.each do |locale|
    I18n.with_locale(locale) do

      add "#{locale.to_s == I18n.default_locale.to_s ? '' : "/#{locale}"}/services/safe_deal"
      add "#{locale.to_s == I18n.default_locale.to_s ? '' : "/#{locale}"}/services/verification"
      add "#{locale.to_s == I18n.default_locale.to_s ? '' : "/#{locale}"}/about"
      add "#{locale.to_s == I18n.default_locale.to_s ? '' : "/#{locale}"}/how_it_works"
      add "#{locale.to_s == I18n.default_locale.to_s ? '' : "/#{locale}"}/pricing"
      add "#{locale.to_s == I18n.default_locale.to_s ? '' : "/#{locale}"}/faq"
      # add "#{locale.to_s == I18n.default_locale.to_s ? '' : "/#{locale}"}/articles"

      Content::Post.active.find_each do |item|
        add article_path(id: item.seo_name,locale:locale.to_s == I18n.default_locale.to_s ? nil : locale),  lastmod: item.created_at
      end


      Content::SeoPage.marketplace_types.values.each do |t|

        Content::SeoPage.country.find_each do |item|
          add country_seo_page_path(marketplace_type: t, country_code: item.country_code,locale:locale.to_s == I18n.default_locale.to_s ? nil : locale), lastmod: item.created_at
        end

        Content::SeoPage.category.find_each do |item|
          add category_seo_page_path(marketplace_type: t, category_seo: item.category_seo,locale:locale.to_s == I18n.default_locale.to_s ? nil : locale), lastmod: item.created_at
        end

        Content::SeoPage.country_category.find_each do |item|
          add country_category_seo_page_path(marketplace_type: t, country_code: item.country_code,category_seo: item.category_seo,locale:locale.to_s == I18n.default_locale.to_s ? nil : locale), lastmod: item.created_at
        end


      end


    end
  end
end
SitemapGenerator::Sitemap.ping_search_engines if Rails.env.production?

