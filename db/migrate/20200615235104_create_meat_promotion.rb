class CreateMeatPromotion < ActiveRecord::Migration[6.0]

  def change
    create_table :meat_promotions do |t|
      t.string :promo_type, null:false
      t.string "promotable_type", null: false
      t.integer "promotable_id", null: false
      t.integer "company_id", null: false
      t.integer "company_user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

