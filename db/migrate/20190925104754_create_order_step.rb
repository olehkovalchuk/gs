class CreateOrderStep < ActiveRecord::Migration[6.0]

  def change

    create_table :order_steps do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer :index, null: false
      t.jsonb :title, null:false, default:{}
      t.boolean :completed, default: false 
      t.boolean :seller_step, default: true 
      t.jsonb :required_fields, null:false, default:[]
    end

  end
end

