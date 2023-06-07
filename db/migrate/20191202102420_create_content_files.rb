class CreateContentFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :content_images do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
