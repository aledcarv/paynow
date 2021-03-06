# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_26_164541) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "boleto_methods", force: :cascade do |t|
    t.string "bank_code"
    t.string "agency_number"
    t.string "bank_account"
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_boleto_methods_on_company_id"
    t.index ["payment_method_id"], name: "index_boleto_methods_on_payment_method_id"
  end

  create_table "card_methods", force: :cascade do |t|
    t.string "card_code"
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_card_methods_on_company_id"
    t.index ["payment_method_id"], name: "index_card_methods_on_payment_method_id"
  end

  create_table "charges", force: :cascade do |t|
    t.decimal "original_value"
    t.decimal "discount_value"
    t.string "token"
    t.integer "status", default: 1
    t.string "final_client_name"
    t.string "final_client_cpf"
    t.string "card_number"
    t.string "card_printed_name"
    t.string "verification_code"
    t.string "address"
    t.string "company_token"
    t.string "product_token"
    t.string "payment_method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "due_date"
  end

  create_table "companies", force: :cascade do |t|
    t.string "cnpj"
    t.string "name"
    t.string "financial_adress"
    t.string "financial_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
    t.index ["token"], name: "index_companies_on_token", unique: true
  end

  create_table "final_client_companies", force: :cascade do |t|
    t.integer "final_client_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_final_client_companies_on_company_id"
    t.index ["final_client_id"], name: "index_final_client_companies_on_final_client_id"
  end

  create_table "final_clients", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.decimal "tax_porcentage"
    t.decimal "tax_maximum"
    t.boolean "status", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "payment_type", null: false
  end

  create_table "pix_methods", force: :cascade do |t|
    t.string "bank_code"
    t.string "key_pix"
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_pix_methods_on_company_id"
    t.index ["payment_method_id"], name: "index_pix_methods_on_payment_method_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.decimal "boleto_discount", default: "0.0"
    t.decimal "pix_discount", default: "0.0"
    t.decimal "card_discount", default: "0.0"
    t.string "token"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.date "due_date"
    t.date "paid_date"
    t.string "authorization_code"
    t.integer "charge_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["charge_id"], name: "index_receipts_on_charge_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id"
    t.integer "role", default: 0, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "boleto_methods", "companies"
  add_foreign_key "boleto_methods", "payment_methods"
  add_foreign_key "card_methods", "companies"
  add_foreign_key "card_methods", "payment_methods"
  add_foreign_key "final_client_companies", "companies"
  add_foreign_key "final_client_companies", "final_clients"
  add_foreign_key "pix_methods", "companies"
  add_foreign_key "pix_methods", "payment_methods"
  add_foreign_key "products", "companies"
  add_foreign_key "receipts", "charges"
  add_foreign_key "users", "companies"
end
