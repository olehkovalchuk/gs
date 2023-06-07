class CreateMeatCategory < ActiveRecord::Migration[6.0]

  def change

    create_table :meat_categories do |t|
      t.jsonb :title, null: false, default: {}
      t.string :icon
      t.string :seo_name, null: false
      t.boolean :active, default: true, index: true

      t.integer :offers_count, null: false, default: 0
      t.integer :requests_count, null: false, default: 0

      t.integer :parent_id, null: false, default: 0
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

