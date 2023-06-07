class CreateMeatQuickOffer < ActiveRecord::Migration[6.0]
  def change
    create_table :meat_quick_offers do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "email", null: false
      t.float "price", null: false
      t.string "country_code", null: false
      t.integer "category_id", null: false
      t.integer "user_id", null: false
      t.integer "company_id", null: false
    end
  end
end
