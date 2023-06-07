class CreateOrderFile < ActiveRecord::Migration[6.0]

  def change

    create_table :order_files do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer :process_id
      t.integer :document_id
    end

  end
end

