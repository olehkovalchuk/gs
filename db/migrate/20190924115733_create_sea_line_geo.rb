class CreateSeaLineGeo < ActiveRecord::Migration[6.0]

  def change

    create_table :geo_sea_lines do |t|
      t.string :title, null: false
      t.string :code
      t.boolean :active, default: true, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

