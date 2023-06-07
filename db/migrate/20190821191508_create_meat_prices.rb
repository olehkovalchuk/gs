class CreateMeatPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :meat_prices do |t|
      t.string :key, null: false
      t.float :value, null: false, default:[],array: true
    end
  end
end
