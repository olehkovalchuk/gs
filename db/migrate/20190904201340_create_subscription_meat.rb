class CreateSubscriptionMeat < ActiveRecord::Migration[6.0]

  def change

    create_table :subscription_meats do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

