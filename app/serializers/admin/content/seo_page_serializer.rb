module Admin

    module Content
      module SeoPageSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :country_code, :category_seo, :page_type, :has_own_text, :marketplace_type
          translated :text, :meta_title, :meta_description
          
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :page_type, :country_title, :category_title, :marketplace_type, :link
          attribute :has_own_text, type: :state

          def link
            href = case object.page_type
            when 'category'
              "/category/#{object.category_seo}/#{object.marketplace_type}"
            when 'country_category'
              "/category/#{object.country_code}/#{object.category_seo}/#{object.marketplace_type}"
            when 'country'
              "/country/#{object.country_code}/#{object.marketplace_type}"
            end
            "<a href=\"#{href}\" target=\"_blank\">Show</a>".html_safe
          end
        end
      end
    end

end
