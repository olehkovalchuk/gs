class AddMetaTitleToContentSeoPages < ActiveRecord::Migration[6.0]
  def change
    add_column :content_seo_pages, :meta_title, :jsonb, null: false, default:{}
    add_column :content_seo_pages, :meta_description, :jsonb, null: false, default:{}
    add_column :content_seo_pages, :category_seo, :string
    remove_column :content_seo_pages, :category_id
    change_column :content_seo_pages, :country_code, :string, null: true
  end
end
