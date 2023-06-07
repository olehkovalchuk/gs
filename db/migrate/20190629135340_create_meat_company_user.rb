class CreateMeatCompanyUser < ActiveRecord::Migration[6.0]

  def change

    create_table :meat_company_users do |t|

      t.integer :processes_count, null:false, default:0
      t.integer :offers_count, null:false, default:0
      t.integer :requests_count, null:false, default:0
      t.integer :managers_count, null:false, default:0
      t.integer :chats_count, null:false, default:0
      t.integer :new_messages_count, null:false, default:0

      t.string :phone
      t.string :first_name, null:false
      t.string :last_name, null:false
      t.string :title, null: false
      t.string :email, null: false
      t.integer :company_id, null: false
      t.boolean :is_company_owner, default: false, null: false
      
      t.text "password_digest"
      t.integer "wrong_password_attempts", default: 0, null: false
      t.integer "signins_count", default: 0, null: false
      t.boolean "active", default: true, null: false
      t.boolean "blocked", default: false, null: false
      t.datetime "blocked_until"
      t.string "locale", default: I18n.default_locale.to_s, null: false
      t.string "reset_password_token"
      t.datetime "reset_password_expire_at"

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    add_index :meat_company_users, [:email,:active], unique: true

  end
end

