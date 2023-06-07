class CreateDeliveryCondition < ActiveRecord::Migration[6.0]

  def change

    create_table :delivery_conditions do |t|
      t.boolean :active, default: false, index: true
      t.string :code, null: false, limit:3, index: true, unique: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

