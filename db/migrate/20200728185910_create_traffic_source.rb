class CreateTrafficSource < ActiveRecord::Migration[6.0]

  def change

    create_table :traffic_sources do |t|
      t.string :title
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

