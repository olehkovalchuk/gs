class CreateGeoRegion < ActiveRecord::Migration[6.0]

  def change

    create_table :geo_regions do |t|
      t.string :code, null: false, limit:2, index: true, unique: true
      t.jsonb :title, null: false, default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

