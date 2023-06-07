class CreateServicePromotion < ActiveRecord::Migration[6.0]

  def change

    create_table :service_promotions do |t|
      t.string :status, null:false
      t.float :price, null: false
      t.string :currency, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

