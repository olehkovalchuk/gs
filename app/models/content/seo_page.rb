
module Content
  class SeoPage  < ApplicationRecord
    enum page_type: {
      country: "country",
      category: "category",
      country_category: "country_category"
    }

    enum marketplace_type: {
      sell: 'sell',
      buy: 'buy'
    }

    multilang :meta_title, :meta_description, :text

    belongs_to :category, class_name: "::Meat::Category", foreign_key: :category_seo, primary_key: :seo_name, optional: true
    belongs_to :country, class_name: "::Geo::Country", foreign_key: :country_code, primary_key: :code, optional: true

    delegate :title, to: :category, prefix: true, allow_nil:true
    delegate :title, to: :country, prefix: true, allow_nil:true

  end
end



