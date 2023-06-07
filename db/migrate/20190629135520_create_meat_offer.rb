class CreateMeatOffer < ActiveRecord::Migration[6.0]

  def change

    create_table :meat_offers do |t|

      t.integer :category_id, null: false
      t.integer :company_id, null: false
      t.integer :company_user_id, null: false
      t.string :delivery_conditions, array: true, default:[]
      t.string :payment_types, array: true, default:[]
      t.integer :certificates, array: true, default:[]
      t.integer :documents, array: true, default:[]
      t.integer :packages, array: true, default:[]

      t.jsonb :permissions_to, null: false, default:[]

      t.string :package_type, null:false, default: "fixed"

      t.integer :weight_from
      t.integer :weight_to
      t.integer :weight_type, limit:1
      t.integer :length_from
      t.integer :length_to
      t.integer :length_type, limit:1

      t.text :description
      t.float :price, null: false
      t.string :plant_number

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

