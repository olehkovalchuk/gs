class CreateOrderServiceItem < ActiveRecord::Migration[6.0]

  def change

    create_table :order_service_items do |t|
      t.string :title, null: false 
      t.integer :position
      t.integer :service_category_id, null: false, index: true
      t.boolean :active, null:false, default: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

