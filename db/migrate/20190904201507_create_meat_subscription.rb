class CreateMeatSubscription < ActiveRecord::Migration[6.0]

  def change

    create_table :meat_subscriptions do |t|
      t.integer :company_id, null:false
      t.integer :company_user_id, null:false
      t.integer :category_ids, null:false, array: true, default: []
      t.string :type, null:false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end


  end
end

