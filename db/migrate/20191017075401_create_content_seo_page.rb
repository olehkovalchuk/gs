class CreateContentSeoPage < ActiveRecord::Migration[6.0]

  def change

    create_table :content_seo_pages do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string :country_code, null: false, limit:2
      t.integer :category_id
      t.string :page_type
      t.boolean :has_own_text
      t.jsonb :text, null:false, default: {}
    end

  end
end

