class CreateBeOneAdminTables < ActiveRecord::Migration[6.0]

  def change

    create_table :global_supplies_settings do |t|
      t.jsonb "value", null: false
      t.string "code", null: false, index:true, unique: true
      t.string "setting_type", default: "string", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    enable_extension 'ltree'
    create_table :"#{BeOneAdmin.config.table_prefix}_users" do |t|
      t.string "email", null: false, index: true, unique: true
      t.string "first_name", null: false
      t.string "last_name", null: false
      t.string "title", null: false
      t.text "password_digest"
      t.integer "wrong_password_attempts", default: 0, null: false
      t.integer "signins_count", default: 0, null: false
      t.boolean "active", default: true, null: false
      t.boolean "blocked", default: false, null: false
      t.datetime "blocked_until"
      t.jsonb "permissions", default: {}, null: false
      t.string "locale", default: I18n.default_locale.to_s, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_expire_at"
      t.string "accessable_type"
      t.integer "accessable_id"
      t.boolean "has_child_resource_scope", default: false, null: false
      t.boolean "has_root_resource_scope", default: false, null: false
      t.ltree "path", null: false
      t.jsonb "additional_attributes", default: {}, null: false
    end 
    add_index :"#{BeOneAdmin.config.table_prefix}_users", ["accessable_type", "accessable_id"]
    add_index :"#{BeOneAdmin.config.table_prefix}_users", :path, using: :gist

    create_table :"#{BeOneAdmin.config.table_prefix}_permissions" do |t|
      t.jsonb "title", default: {}, null: false
      t.string "controller", null: false
      t.string "actions", default: [], null: false, array: true
      t.boolean "allowed", default: true, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table :"#{BeOneAdmin.config.table_prefix}_roles" do |t|
      t.jsonb "title", default: {}, null: false
      t.jsonb "description", default: {}, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table :"#{BeOneAdmin.config.table_prefix}_permissions_roles" do |t|
      t.integer :role_id, null: false
      t.integer :permission_id, null: false
    end

    add_index :"#{BeOneAdmin.config.table_prefix}_permissions_roles", :permission_id
    add_index :"#{BeOneAdmin.config.table_prefix}_permissions_roles", :role_id


    create_table :"#{BeOneAdmin.config.table_prefix}_permissions_users" do |t|
      t.integer :user_id, null: false
      t.integer :permission_id, null: false
    end
    add_index :"#{BeOneAdmin.config.table_prefix}_permissions_users", :permission_id
    add_index :"#{BeOneAdmin.config.table_prefix}_permissions_users", :user_id

    create_table :"#{BeOneAdmin.config.table_prefix}_roles_users" do |t|
      t.integer :user_id, null: false
      t.integer :role_id, null: false
    end
    add_index :"#{BeOneAdmin.config.table_prefix}_roles_users", :user_id
    add_index :"#{BeOneAdmin.config.table_prefix}_roles_users", :role_id


    create_table :"#{BeOneAdmin.config.table_prefix}_menus" do |t|
      t.jsonb "title", default: {}, null: false
      t.integer "parent_id", default: 0, null: false, index: true
      t.string "controller", null:false, index: true, unique: true
      t.string "icon", default: 'fa-align-left'
      t.integer "position", default: 1, null: false
      t.boolean "deleted", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table :"#{BeOneAdmin.config.table_prefix}_confirmations" do |t|
      t.integer :notification_id, null: false
      t.integer :user_id, null: false
      t.boolean "read", default: false
      t.datetime "reading_date"
    end
    add_index :"#{BeOneAdmin.config.table_prefix}_confirmations", [  :notification_id, :user_id ], unique: true


    create_table :"#{BeOneAdmin.config.table_prefix}_notifications" do |t|
      t.jsonb "heading", default: {}, null: false
      t.jsonb "text", default: {}, null: false
      t.integer "message_type", default: 0
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "user_id", null: false
      t.boolean "send_email", default: false
      t.boolean "send_sms", default: false
    end

    add_index :"#{BeOneAdmin.config.table_prefix}_notifications", :user_id
    add_index :"#{BeOneAdmin.config.table_prefix}_notifications", :message_type


    create_table :"#{BeOneAdmin.config.table_prefix}_emails" do |t|
      t.jsonb "subject", default: {}, null: false
      t.jsonb "text", default: {}, null: false
      t.string "code", null: false
    end

    add_index :"#{BeOneAdmin.config.table_prefix}_emails", :code



  end
end