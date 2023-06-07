class CreateContentPost < ActiveRecord::Migration[6.0]

  def change

    create_table :content_posts do |t|
      t.jsonb :title, null: false, default: {}
      t.jsonb :text, null: false, default: {}
      t.boolean :active, default: false, index: true
      t.string :seo_name, null: false, index: true, unique: true
      t.jsonb :meta_description, null: false, default: {}
      t.jsonb :meta_title, null: false, default: {}
      t.jsonb :anons, null: false, default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

