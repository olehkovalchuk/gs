class CreateOrderPackage < ActiveRecord::Migration[6.0]

  def change

    create_table :order_packages do |t|
      t.float :price, null:false, default: 0.0
      t.string :title, null: false
      t.string :description, null: false
      t.integer :offers_count, null: false, default: 0
      t.integer :requests_count, null: false, default: 0
      t.integer :received_inquries, null: false, default: 0
      t.integer :replyies_to_inquries, null: false, default: 0
      t.boolean :map_access, null: false, default: false 
      t.boolean :is_best, null: false, default: false
      t.boolean :active, null: false, default: true
      t.integer :active_chats, null: false, default: 0
      t.integer :show_infos, null: false, default: 0
      t.integer :buyer_allerts, null: false, default: 0
      t.integer :sub_accounts, null: false, default: 0
      t.string :rating_code, null: false, default: 'fresh'
      t.string :currency, null: false, default: 'USD'
      t.jsonb :offline_packages, null: false, default: {}

      t.string :performance, null: false, default: ''
      t.string :reports, null: false, default: ''

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

