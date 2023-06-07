class CreateGeoPort < ActiveRecord::Migration[6.0]

  def change

    create_table :geo_ports do |t|
      t.jsonb :title, null: false, default: {}
      t.boolean :active, default: true, index: true
      t.string :code, null: false, limit:6, index: true, unique: true
      t.string :country_code, null: false, limit:2, index: true
      t.string :region_code, null: false, limit:3, index: true
      t.float :latitude, null:false, default: 0.0
      t.float :longitude, null:false, default: 0.0
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

