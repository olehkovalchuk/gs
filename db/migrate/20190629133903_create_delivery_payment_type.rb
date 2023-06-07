class CreateDeliveryPaymentType < ActiveRecord::Migration[6.0]

  def change

    create_table :delivery_payment_types do |t|
      t.jsonb :title, null: false, default: {}
      t.boolean :active, default: false, index: true
      t.string :code, null: false, limit:6, index: true, unique: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

