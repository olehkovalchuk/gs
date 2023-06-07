class CreateOfferService < ActiveRecord::Migration[6.0]

  def change

    create_table :offer_services do |t|
      t.jsonb :title, null:false, default:{}
      t.string :code, null:false
      t.float :price, null:false
      t.float :old_price
      t.integer :usage_period
      t.string :usage_type, nulll: false
      t.jsonb :usage_title, null:false, default:{}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean :active, default: true
      t.boolean :deleted, default: false
    end

  end
end

