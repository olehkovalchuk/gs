class CreateDeliveryPackage < ActiveRecord::Migration[6.0]

  def change

    create_table :delivery_packages do |t|
      t.jsonb :title, null: false, default: {}
      t.boolean :active, default: true, index: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

