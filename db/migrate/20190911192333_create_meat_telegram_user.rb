class CreateMeatTelegramUser < ActiveRecord::Migration[6.0]

  def change

    create_table :meat_telegram_users do |t|
      t.integer :telegram_id, null: false
      t.string :name, null: false
      t.integer :category_id
      t.string :locale, null: false, default: "en"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

