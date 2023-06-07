class AddMarketplaceTypeToContentSeoPages < ActiveRecord::Migration[6.0]
  def change
    add_column :content_seo_pages, :marketplace_type, :string, null:false, default: "sell"
  end
end
