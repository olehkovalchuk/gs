# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_14_140752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "ltree"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_confirmations", force: :cascade do |t|
    t.integer "notification_id", null: false
    t.integer "user_id", null: false
    t.boolean "read", default: false
    t.datetime "reading_date"
    t.index ["notification_id", "user_id"], name: "index_admin_confirmations_on_notification_id_and_user_id", unique: true
  end

  create_table "admin_emails", force: :cascade do |t|
    t.jsonb "subject", default: {}, null: false
    t.jsonb "text", default: {}, null: false
    t.string "code", null: false
    t.index ["code"], name: "index_admin_emails_on_code"
  end

  create_table "admin_menus", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.integer "parent_id", default: 0, null: false
    t.string "controller", null: false
    t.string "icon", default: "fa-align-left"
    t.integer "position", default: 1, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller"], name: "index_admin_menus_on_controller"
    t.index ["parent_id"], name: "index_admin_menus_on_parent_id"
  end

  create_table "admin_notifications", force: :cascade do |t|
    t.jsonb "heading", default: {}, null: false
    t.jsonb "text", default: {}, null: false
    t.integer "message_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.boolean "send_email", default: false
    t.boolean "send_sms", default: false
    t.index ["message_type"], name: "index_admin_notifications_on_message_type"
    t.index ["user_id"], name: "index_admin_notifications_on_user_id"
  end

  create_table "admin_permissions", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.string "controller", null: false
    t.string "actions", default: [], null: false, array: true
    t.boolean "allowed", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_permissions_roles", force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "permission_id", null: false
    t.index ["permission_id"], name: "index_admin_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_admin_permissions_roles_on_role_id"
  end

  create_table "admin_permissions_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "permission_id", null: false
    t.index ["permission_id"], name: "index_admin_permissions_users_on_permission_id"
    t.index ["user_id"], name: "index_admin_permissions_users_on_user_id"
  end

  create_table "admin_roles", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.jsonb "description", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_roles_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.index ["role_id"], name: "index_admin_roles_users_on_role_id"
    t.index ["user_id"], name: "index_admin_roles_users_on_user_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", null: false
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
    t.string "locale", default: "en", null: false
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
    t.index ["accessable_type", "accessable_id"], name: "index_admin_users_on_accessable_type_and_accessable_id"
    t.index ["email"], name: "index_admin_users_on_email"
    t.index ["path"], name: "index_admin_users_on_path", using: :gist
  end

  create_table "chat_contacts", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_conversations", force: :cascade do |t|
    t.integer "sender_company_id", null: false
    t.integer "sender_company_user_id", null: false
    t.integer "recipient_company_id", null: false
    t.integer "recipient_company_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.boolean "deleted", default: true
    t.boolean "has_new_messages", default: true, null: false
    t.boolean "with_messages", default: false
    t.boolean "sender_new_messages", default: false
    t.boolean "recipient_new_messages", default: false
  end

  create_table "chat_feedbacks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "text"
    t.integer "rating", default: 0, null: false
    t.jsonb "rating_extended", default: {}, null: false
    t.integer "sender_company_id", null: false
    t.integer "sender_company_user_id", null: false
    t.integer "recipient_company_id", null: false
    t.integer "recipient_company_user_id", null: false
    t.boolean "active", default: true
    t.boolean "deleted", default: true
  end

  create_table "chat_inquiries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sender_email", null: false
    t.string "title", null: false
    t.integer "recipient_company_id", null: false
    t.integer "recipient_company_user_id", null: false
    t.integer "sender_company_id"
    t.integer "sender_company_user_id"
    t.integer "parent_id", default: 0, null: false
    t.string "receiver_email", null: false
    t.integer "inquirieable_id", null: false
    t.string "inquirieable_type", null: false
    t.text "message", null: false
    t.string "status", default: "created", null: false
    t.string "inquiry_email"
    t.boolean "income", default: true
    t.string "phone"
    t.boolean "post_request", default: false
    t.string "country_code", limit: 2
    t.string "phone_number"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer "sender_id", null: false
    t.integer "recipient_id", null: false
    t.integer "conversation_id", null: false
    t.text "text", null: false
    t.boolean "readed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender_company_id"
    t.integer "recipient_company_id"
    t.string "status", default: "sent", null: false
  end

  create_table "chat_notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender_company_id", null: false
    t.integer "sender_company_user_id", null: false
    t.integer "recipient_company_id", null: false
    t.integer "recipient_company_user_id", null: false
    t.string "comment", null: false
    t.string "action", null: false
    t.string "notificable_type", null: false
    t.integer "notificable_id", null: false
    t.jsonb "params", default: {}, null: false
    t.string "item_type"
    t.boolean "read", default: false, null: false
  end

  create_table "content_email_templates", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.jsonb "text", default: {}, null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_content_email_templates_on_code"
  end

  create_table "content_faqs", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.jsonb "text", default: {}, null: false
    t.boolean "active", default: false
    t.string "seo_name", null: false
    t.string "category", null: false
    t.jsonb "meta_description", default: {}, null: false
    t.jsonb "meta_title", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_content_faqs_on_active"
    t.index ["category"], name: "index_content_faqs_on_category"
    t.index ["seo_name"], name: "index_content_faqs_on_seo_name"
  end

  create_table "content_images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_pages", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.jsonb "text", default: {}, null: false
    t.boolean "active", default: false
    t.string "seo_name", null: false
    t.jsonb "meta_description", default: {}, null: false
    t.jsonb "meta_title", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_content_pages_on_active"
    t.index ["seo_name"], name: "index_content_pages_on_seo_name"
  end

  create_table "content_posts", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.jsonb "text", default: {}, null: false
    t.boolean "active", default: false
    t.string "seo_name", null: false
    t.jsonb "meta_description", default: {}, null: false
    t.jsonb "meta_title", default: {}, null: false
    t.jsonb "anons", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_content_posts_on_active"
    t.index ["seo_name"], name: "index_content_posts_on_seo_name"
  end

  create_table "content_seo_pages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country_code"
    t.string "page_type"
    t.boolean "has_own_text"
    t.jsonb "text", default: {}, null: false
    t.jsonb "meta_title", default: {}, null: false
    t.jsonb "meta_description", default: {}, null: false
    t.string "category_seo"
    t.string "marketplace_type", default: "sell", null: false
  end

  create_table "delivery_conditions", force: :cascade do |t|
    t.boolean "active", default: false
    t.string "code", limit: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "need_seller_port", default: false, null: false
    t.boolean "need_seller_country", default: false, null: false
    t.boolean "need_buyer_port", default: false, null: false
    t.boolean "need_buyer_country", default: false, null: false
    t.boolean "active_for_offers"
    t.boolean "active_for_requests"
    t.boolean "need_sea_line", default: false
    t.boolean "safe_deal", default: false
    t.index ["active"], name: "index_delivery_conditions_on_active"
    t.index ["code"], name: "index_delivery_conditions_on_code"
  end

  create_table "delivery_packages", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "markets", default: ["meat"], null: false, array: true
    t.index ["active"], name: "index_delivery_packages_on_active"
  end

  create_table "delivery_payment_types", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_for_offers"
    t.boolean "active_for_requests"
    t.boolean "has_prepay", default: false
    t.index ["active"], name: "index_delivery_payment_types_on_active"
  end

  create_table "delivery_step_fields", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.string "field_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delivery_steps", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.string "delivery_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 1, null: false
    t.boolean "seller_step"
    t.boolean "buyer_step"
    t.jsonb "required_fields", default: [], null: false
  end

  create_table "delivery_steps_step_fields", force: :cascade do |t|
    t.integer "field_id", null: false
    t.integer "step_id", null: false
  end

  create_table "geo_countries", force: :cascade do |t|
    t.string "code", limit: 2, null: false
    t.string "region_code", limit: 3, null: false
    t.jsonb "title", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_offers_origin", default: false
    t.boolean "active_requests_origin", default: false
    t.boolean "active_offers_permission", default: false
    t.boolean "active_requests_permission", default: false
    t.index ["code"], name: "index_geo_countries_on_code"
    t.index ["region_code"], name: "index_geo_countries_on_region_code"
  end

  create_table "geo_ports", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.boolean "active", default: true
    t.string "code", limit: 50, null: false
    t.string "country_code", limit: 2, null: false
    t.string "region_code", limit: 3, null: false
    t.float "latitude", default: 0.0, null: false
    t.float "longitude", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_geo_ports_on_active"
    t.index ["code"], name: "index_geo_ports_on_code"
    t.index ["country_code"], name: "index_geo_ports_on_country_code"
    t.index ["region_code"], name: "index_geo_ports_on_region_code"
  end

  create_table "geo_regions", force: :cascade do |t|
    t.string "code", limit: 2, null: false
    t.jsonb "title", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_for_offers", default: true, null: false
    t.boolean "active_for_requests", default: true, null: false
    t.boolean "active", default: true, null: false
    t.index ["code"], name: "index_geo_regions_on_code"
  end

  create_table "geo_sea_lines", force: :cascade do |t|
    t.string "title", null: false
    t.string "code"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "global_supplies_settings", force: :cascade do |t|
    t.jsonb "value", null: false
    t.string "code", null: false
    t.string "setting_type", default: "string", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_global_supplies_settings_on_code"
  end

  create_table "meat_alerts", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "company_id", null: false
    t.index ["category_id"], name: "index_meat_alerts_on_category_id"
    t.index ["company_id"], name: "index_meat_alerts_on_company_id"
  end

  create_table "meat_bids", force: :cascade do |t|
    t.string "currency", null: false
    t.float "amount", null: false
    t.string "comment"
    t.string "bidable_type", null: false
    t.integer "bidable_id", null: false
    t.integer "sender_company_id", null: false
    t.integer "sender_company_user_id", null: false
    t.integer "recipient_company_id", null: false
    t.integer "recipient_company_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  create_table "meat_categories", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.string "icon"
    t.string "seo_name", null: false
    t.boolean "active", default: true
    t.integer "offers_count", default: 0, null: false
    t.integer "requests_count", default: 0, null: false
    t.integer "parent_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_for_offers", default: false
    t.boolean "active_for_requests", default: false
    t.ltree "path"
    t.string "cls"
    t.integer "position", default: 0
    t.string "market", default: "meat", null: false
    t.index ["active"], name: "index_meat_categories_on_active"
    t.index ["parent_id"], name: "index_meat_categories_on_parent_id"
  end

  create_table "meat_certificates", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "markets", default: ["meat"], null: false, array: true
    t.index ["active"], name: "index_meat_certificates_on_active"
  end

  create_table "meat_companies", force: :cascade do |t|
    t.integer "processes_count", default: 0, null: false
    t.integer "offers_count", default: 0, null: false
    t.integer "requests_count", default: 0, null: false
    t.integer "managers_count", default: 0, null: false
    t.integer "new_messages_count", default: 0, null: false
    t.integer "rating", default: 0, null: false
    t.string "rating_code", default: "fresh", null: false
    t.string "country_code", limit: 2
    t.string "phone"
    t.string "title", null: false
    t.string "seo_name", null: false
    t.string "iban"
    t.string "swift"
    t.string "account_number"
    t.string "tic"
    t.string "vat"
    t.string "eori"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "blocked_until"
    t.boolean "active", default: true
    t.boolean "blocked", default: false
    t.integer "bids_in_count", default: 0, null: false
    t.integer "bids_out_count", default: 0, null: false
    t.integer "incoming_chats_count", default: 0, null: false
    t.integer "outgoing_chats_count", default: 0, null: false
    t.integer "active_offers", default: 0
    t.integer "incomming_offer_views", default: 0
    t.integer "incomming_uniq_offer_views", default: 0
    t.integer "incomming_invoice", default: 0
    t.integer "incomming_safe_deals_count", default: 0
    t.integer "outgoing_offer_views", default: 0
    t.integer "outgoing_uniq_offer_views", default: 0
    t.integer "outgoing_invoice", default: 0
    t.integer "outgoing_safe_deals_count", default: 0
    t.string "role", default: "trader", null: false
    t.text "about"
    t.string "address"
    t.integer "total_emploees"
    t.integer "year_establishment"
    t.integer "success_deal", default: 0, null: false
    t.string "plant_number"
    t.string "representative"
    t.string "zip"
    t.string "zip_address"
    t.string "bank_country", limit: 2
    t.string "bank"
    t.string "city"
    t.boolean "pasport_verified", default: false
    t.boolean "bill_verified", default: false
    t.boolean "moderated", default: true
    t.boolean "on_map", default: false
    t.float "latitude", default: 0.0, null: false
    t.float "longitude", default: 0.0, null: false
    t.jsonb "rating_extended", default: {"info"=>0, "offers"=>0, "activity"=>0, "authorization"=>0}, null: false
    t.integer "category_ids", default: [], null: false, array: true
    t.integer "certificates", default: [], null: false, array: true
    t.string "phone_number"
    t.integer "used_ininquies_count", default: 0, null: false
    t.integer "offers_count_limit", default: 0, null: false
    t.integer "offers_count_used", default: 0
    t.integer "requests_count_limit", default: 0, null: false
    t.integer "requests_count_used", default: 0
    t.integer "received_inquries_limit", default: 0, null: false
    t.integer "received_inquries_used", default: 0
    t.integer "replyies_to_inquries_limit", default: 0, null: false
    t.integer "replyies_to_inquries_used", default: 0
    t.integer "active_chats_limit", default: 0, null: false
    t.integer "active_chats_used", default: 0
    t.integer "show_infos_limit", default: 0, null: false
    t.integer "show_infos_used", default: 0
    t.integer "buyer_allerts_limit", default: 0, null: false
    t.integer "buyer_allerts_used", default: 0
    t.integer "sub_accounts_limit", default: 0, null: false
    t.integer "sub_accounts_used", default: 0
    t.integer "offers_limit", default: 0, null: false
    t.integer "offers_used", default: 0
    t.integer "sended_inquries_limit", default: 0, null: false
    t.integer "sended_inquries_used", default: 0
    t.integer "top_offers_limit", default: 0, null: false
    t.integer "top_offers_used", default: 0
    t.date "package_expiration", default: "2023-07-31", null: false
    t.string "markets", default: ["meat"], null: false, array: true
    t.index ["seo_name"], name: "index_meat_companies_on_seo_name"
  end

  create_table "meat_company_users", force: :cascade do |t|
    t.integer "processes_count", default: 0, null: false
    t.integer "offers_count", default: 0, null: false
    t.integer "requests_count", default: 0, null: false
    t.integer "new_messages_count", default: 0, null: false
    t.string "phone"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "title", null: false
    t.string "email", null: false
    t.integer "company_id", null: false
    t.boolean "is_company_owner", default: false, null: false
    t.text "password_digest"
    t.integer "wrong_password_attempts", default: 0, null: false
    t.integer "signins_count", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "blocked_until"
    t.string "locale", default: "en", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bids_in_count", default: 0, null: false
    t.integer "bids_out_count", default: 0, null: false
    t.integer "incoming_chats_count", default: 0, null: false
    t.integer "outgoing_chats_count", default: 0, null: false
    t.integer "active_offers", default: 0
    t.integer "incomming_offer_views", default: 0
    t.integer "incomming_uniq_offer_views", default: 0
    t.integer "incomming_invoice", default: 0
    t.integer "incomming_safe_deals_count", default: 0
    t.integer "outgoing_offer_views", default: 0
    t.integer "outgoing_uniq_offer_views", default: 0
    t.integer "outgoing_invoice", default: 0
    t.integer "outgoing_safe_deals_count", default: 0
    t.string "phone_number"
    t.string "country_code", limit: 2
    t.boolean "deleted", default: false
    t.string "otp_secret_key"
    t.boolean "verificated_email", default: false, null: false
    t.boolean "verificated_phone", default: false, null: false
    t.string "verification_codes", default: [], null: false, array: true
    t.datetime "verification_expire"
    t.datetime "notifications_viewed_date"
    t.integer "new_notifications_count", default: 0
    t.index ["email", "active"], name: "index_meat_company_users_on_email_and_active", unique: true
  end

  create_table "meat_documents", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_for_offer", default: true
    t.boolean "active_for_po", default: true
    t.boolean "need_sign", default: false
    t.boolean "need_before_sign"
    t.string "template"
    t.string "markets", default: ["meat"], null: false, array: true
    t.index ["active"], name: "index_meat_documents_on_active"
  end

  create_table "meat_invoices", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "company_user_id", null: false
    t.integer "process_id"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment"
    t.index ["company_id"], name: "index_meat_invoices_on_company_id"
    t.index ["company_user_id"], name: "index_meat_invoices_on_company_user_id"
  end

  create_table "meat_offers", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "company_id", null: false
    t.integer "company_user_id", null: false
    t.string "delivery_conditions", default: [], array: true
    t.string "payment_types", default: [], array: true
    t.integer "certificates", default: [], array: true
    t.integer "documents", default: [], array: true
    t.integer "packages", default: [], array: true
    t.jsonb "permissions_to", default: [], null: false
    t.string "package_type", default: "fixed", null: false
    t.float "weight_from"
    t.float "weight_to"
    t.string "weight_type", limit: 2
    t.float "length_from"
    t.float "length_to"
    t.string "length_type", limit: 2
    t.text "description"
    t.string "plant_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "origin", limit: 2, null: false
    t.jsonb "plain_permissions", default: [], null: false
    t.string "delivery_type"
    t.string "delivery_port"
    t.string "delivery_country"
    t.string "currency"
    t.string "price_type", default: "MT"
    t.float "quantity", null: false
    t.string "quantity_type", default: "T", null: false
    t.integer "week_from"
    t.integer "week_to"
    t.boolean "active", default: false
    t.boolean "deleted", default: false
    t.float "price_from", default: 0.0, null: false
    t.float "price_to", default: 0.0, null: false
    t.boolean "in_top", default: false
    t.date "in_top_expire_at"
    t.string "market", default: "meat", null: false
  end

  create_table "meat_prices", force: :cascade do |t|
    t.string "key", null: false
    t.float "value", default: [], null: false, array: true
  end

  create_table "meat_promotions", force: :cascade do |t|
    t.string "promo_type", null: false
    t.string "promotable_type", null: false
    t.integer "promotable_id", null: false
    t.integer "company_id", null: false
    t.integer "company_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meat_quick_offers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.float "price", null: false
    t.string "country_code", null: false
    t.integer "category_id", null: false
    t.integer "user_id", null: false
    t.integer "company_id", null: false
  end

  create_table "meat_requests", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "company_id", null: false
    t.integer "company_user_id", null: false
    t.string "delivery_conditions", default: [], array: true
    t.string "payment_types", default: [], array: true
    t.jsonb "permissions_to", default: [], null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "origin", limit: 2
    t.jsonb "plain_permissions", default: [], null: false
    t.string "delivery_type"
    t.string "delivery_port"
    t.string "delivery_country"
    t.string "currency"
    t.string "price_type", default: "MT"
    t.float "quantity", null: false
    t.string "quantity_type", default: "T", null: false
    t.string "origins", default: [], null: false, array: true
    t.boolean "active", default: false
    t.boolean "deleted", default: false
    t.float "price_from", default: 0.0, null: false
    t.float "price_to", default: 0.0, null: false
    t.integer "certificates", default: [], null: false, array: true
    t.integer "documents", default: [], null: false, array: true
    t.boolean "subscribe", default: false
    t.boolean "in_top", default: false
    t.date "in_top_expire_at"
    t.string "market", default: "meat", null: false
  end

  create_table "meat_subscriptions", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "company_user_id", null: false
    t.integer "category_ids", default: [], null: false, array: true
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meat_telegram_users", force: :cascade do |t|
    t.integer "telegram_id", null: false
    t.string "name", null: false
    t.integer "category_id"
    t.string "locale", default: "en", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offer_services", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.string "code", null: false
    t.float "price", null: false
    t.float "old_price"
    t.integer "usage_period"
    t.string "usage_type"
    t.jsonb "usage_title", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.boolean "deleted", default: false
    t.string "currency", default: "USD", null: false
  end

  create_table "order_files", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "process_id"
    t.integer "document_id"
    t.integer "sender_id", null: false
    t.integer "sender_company_id", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.jsonb "title", default: {}, null: false
    t.boolean "is_included", default: true
    t.integer "service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_order_items_on_service_id"
  end

  create_table "order_packages", force: :cascade do |t|
    t.float "price", default: 0.0, null: false
    t.string "description", null: false
    t.integer "offers_count", default: 0, null: false
    t.integer "requests_count", default: 0, null: false
    t.integer "received_inquries", default: 0, null: false
    t.integer "replyies_to_inquries", default: 0, null: false
    t.boolean "map_access", default: false, null: false
    t.boolean "is_best", default: false, null: false
    t.boolean "active", default: true, null: false
    t.integer "active_chats", default: 0, null: false
    t.integer "show_infos", default: 0, null: false
    t.integer "buyer_allerts", default: 0, null: false
    t.integer "sub_accounts", default: 0, null: false
    t.string "rating_code", default: "fresh", null: false
    t.string "currency", default: "USD", null: false
    t.jsonb "offline_packages", default: {}, null: false
    t.string "performance", default: "", null: false
    t.string "reports", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.integer "sended_inquries", default: 0, null: false
    t.integer "top_offers", default: 0, null: false
    t.boolean "default", default: false, null: false
    t.jsonb "title", default: {}, null: false
    t.integer "days", default: 30, null: false
  end

  create_table "order_payment_transactions", force: :cascade do |t|
    t.integer "item_id", null: false
    t.string "status", null: false
    t.string "description", null: false
    t.float "amount", null: false
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_type", null: false
    t.integer "company_id", null: false
    t.string "company_user_id", null: false
    t.string "system", null: false
    t.string "system_id"
    t.string "token", null: false
  end

  create_table "order_proceses", force: :cascade do |t|
    t.string "processable_type", null: false
    t.integer "processable_id", null: false
    t.integer "sender_company_id", null: false
    t.integer "sender_company_user_id", null: false
    t.integer "recipient_company_id", null: false
    t.integer "recipient_company_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "process_id", null: false
    t.integer "payment_type_id"
    t.float "pre_pay"
    t.float "post_pay"
    t.string "origin", limit: 2, null: false
    t.string "title", null: false
    t.integer "quantity", null: false
    t.integer "month_of_production"
    t.integer "price", null: false
    t.string "currency", limit: 3, null: false
    t.integer "documents", default: [], null: false, array: true
    t.text "comment"
    t.string "delivery_code"
    t.string "shiping_line"
    t.string "destination_port"
    t.string "stage", null: false
    t.string "status", null: false
    t.boolean "po_signed_by_seller", default: false
    t.boolean "po_signed_by_buyer", default: false
    t.boolean "po_confirmed_by_seller", default: false
    t.boolean "po_confirmed_by_buyer", default: false
    t.boolean "own_po", default: false
    t.integer "packing"
    t.jsonb "seller_main_contact_person", default: {}, null: false
    t.jsonb "seller_additional_contact_person", default: {}, null: false
    t.jsonb "buyer_main_contact_person", default: {}, null: false
    t.jsonb "buyer_additional_contact_person", default: {}, null: false
    t.jsonb "buyer_company_deails", default: {}, null: false
    t.jsonb "seller_company_deails", default: {}, null: false
    t.boolean "is_safe"
    t.boolean "approved_for_safe"
    t.boolean "uploaded_by_buyer"
    t.boolean "uploaded_by_seller"
  end

  create_table "order_service_categories", force: :cascade do |t|
    t.integer "position"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "title", default: {}, null: false
  end

  create_table "order_service_items", force: :cascade do |t|
    t.integer "position"
    t.integer "service_category_id", null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "title", default: {}, null: false
    t.index ["service_category_id"], name: "index_order_service_items_on_service_category_id"
  end

  create_table "order_steps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", null: false
    t.jsonb "title", default: {}, null: false
    t.boolean "completed", default: false
    t.boolean "seller_step", default: true
    t.jsonb "required_fields", default: [], null: false
    t.datetime "completed_at"
    t.boolean "buyer_step"
    t.integer "process_id", null: false
  end

  create_table "service_promotions", force: :cascade do |t|
    t.string "status", null: false
    t.float "price", null: false
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_safe_deals", force: :cascade do |t|
    t.string "status", null: false
    t.float "price", null: false
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_usage_fees", force: :cascade do |t|
    t.string "status", null: false
    t.float "price", null: false
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_verifications", force: :cascade do |t|
    t.string "status", null: false
    t.float "price", null: false
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "signins", id: :serial, force: :cascade do |t|
    t.integer "signinable_id", null: false
    t.string "signinable_type", null: false
    t.string "token", null: false
    t.string "referer", default: ""
    t.string "user_agent", default: ""
    t.inet "ip", null: false
    t.datetime "expiration_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "custom_data", default: {}, null: false
    t.index ["signinable_id", "signinable_type"], name: "index_signins_on_signinable_id_and_signinable_type"
    t.index ["token"], name: "index_signins_on_token"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_subscribers_on_email"
  end

  create_table "subscription_meats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "traffic_sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.string "user_agent"
    t.string "ip"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
