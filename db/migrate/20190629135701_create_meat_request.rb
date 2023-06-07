class CreateMeatRequest < ActiveRecord::Migration[6.0]

  def change

    create_table :meat_requests do |t|
      t.integer :category_id, null: false
      t.integer :company_id, null: false
      t.integer :company_user_id, null: false
      t.string :delivery_conditions, array: true, default:[]
      t.string :payment_types, array: true, default:[]
      t.jsonb :permissions_to, null: false, default:[]

      t.text :description
      t.float :price, null: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

