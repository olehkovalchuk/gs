class CreateServiceItems < ActiveRecord::Migration[6.0]
  def change
    drop_table :order_items
    create_table :order_items do |t|
      t.jsonb :title, null: false, default: {}
      t.boolean :is_included, default: true
      t.integer :service_id, null:false ,index: true
      t.timestamps
    end
  end
end
