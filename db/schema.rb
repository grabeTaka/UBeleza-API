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

ActiveRecord::Schema.define(version: 2020_03_28_183956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
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

  create_table "addresses", force: :cascade do |t|
    t.string "cep"
    t.string "city"
    t.string "neighborhood"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "uf"
    t.string "district"
    t.string "state"
    t.bigint "establishment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "long"
    t.decimal "lat"
    t.index ["establishment_id"], name: "index_addresses_on_establishment_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "shopping_cart_id", null: false
    t.bigint "product_id", null: false
    t.decimal "unit_price"
    t.integer "quantity"
    t.decimal "total"
    t.string "cancel_cause"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_cart_items_on_product_id"
    t.index ["shopping_cart_id"], name: "index_cart_items_on_shopping_cart_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "category_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "establishment_categories", force: :cascade do |t|
    t.bigint "establishment_id"
    t.bigint "category_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_type_id"], name: "index_establishment_categories_on_category_type_id"
    t.index ["establishment_id"], name: "index_establishment_categories_on_establishment_id"
  end

  create_table "establishments", force: :cascade do |t|
    t.string "name"
    t.jsonb "details", default: "{}"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "establishments_users", force: :cascade do |t|
    t.bigint "establishment_id"
    t.bigint "user_id"
    t.index ["establishment_id"], name: "index_establishments_users_on_establishment_id"
    t.index ["user_id"], name: "index_establishments_users_on_user_id"
  end

  create_table "favorites_establishments", force: :cascade do |t|
    t.bigint "establishment_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["establishment_id"], name: "index_favorites_establishments_on_establishment_id"
    t.index ["user_id"], name: "index_favorites_establishments_on_user_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "product_categories", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "category_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_type_id"], name: "index_product_categories_on_category_type_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price", precision: 12, scale: 2, null: false
    t.jsonb "details", default: "{}", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "establishment_id"
    t.integer "subcategory_id"
    t.index ["details"], name: "index_products_on_details", using: :gin
    t.index ["establishment_id"], name: "index_products_on_establishment_id"
  end

  create_table "products_categories", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_categories_on_category_id"
    t.index ["product_id"], name: "index_products_categories_on_product_id"
  end

  create_table "schedulings", force: :cascade do |t|
    t.bigint "establishment_id"
    t.bigint "user_id"
    t.string "schedule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id"
    t.datetime "start"
    t.datetime "end"
    t.bigint "professional_id"
    t.index ["establishment_id"], name: "index_schedulings_on_establishment_id"
    t.index ["professional_id"], name: "index_schedulings_on_professional_id"
    t.index ["user_id"], name: "index_schedulings_on_user_id"
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.bigint "establishment_id", null: false
    t.bigint "table_id", null: false
    t.bigint "user_id", null: false
    t.integer "status"
    t.decimal "total"
    t.string "cause"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["establishment_id"], name: "index_shopping_carts_on_establishment_id"
    t.index ["table_id"], name: "index_shopping_carts_on_table_id"
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.bigint "category_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["category_type_id"], name: "index_subcategories_on_category_type_id"
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "establishment_id", null: false
    t.string "name"
    t.integer "number"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["establishment_id"], name: "index_tables_on_establishment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_items", "products"
  add_foreign_key "cart_items", "shopping_carts"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "schedulings", "users", column: "professional_id"
  add_foreign_key "shopping_carts", "establishments"
  add_foreign_key "shopping_carts", "tables"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "tables", "establishments"
end
