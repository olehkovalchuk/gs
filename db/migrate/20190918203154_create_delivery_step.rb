class CreateDeliveryStep < ActiveRecord::Migration[6.0]

  def change

    create_table :delivery_steps do |t|
      t.jsonb :title, null: false, default: {}
      t.string :delivery_code, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

