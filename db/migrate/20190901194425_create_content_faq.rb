class CreateContentFaq < ActiveRecord::Migration[6.0]

  def change

    create_table "content_faqs", force: :cascade do |t|
      t.jsonb "title", default: {}, null: false
      t.jsonb "text", default: {}, null: false
      t.boolean "active", default: false, index: true
      t.string "seo_name", null: false, index: true
      t.string "category", null: false, index: true
      t.jsonb "meta_description", default: {}, null: false
      t.jsonb "meta_title", default: {}, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

