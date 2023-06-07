class CreateContentEmailTemplate < ActiveRecord::Migration[6.0]

  def change

    create_table :content_email_templates do |t|
      t.jsonb :title, null: false, default: {}
      t.jsonb :text, null: false, default: {}
      t.string :code, null: false, index: true, unique: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

