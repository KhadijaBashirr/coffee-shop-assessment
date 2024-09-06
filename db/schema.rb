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

ActiveRecord::Schema[7.1].define(version: 2024_09_06_143150) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "discounts", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "required_item_id", null: false
    t.decimal "percentage", precision: 5, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "required_item_id"], name: "index_discounts_on_item_id_and_required_item_id", unique: true
    t.index ["item_id"], name: "index_discounts_on_item_id"
    t.index ["required_item_id"], name: "index_discounts_on_required_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "tax_bucket_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["name"], name: "index_items_on_name", unique: true
    t.index ["tax_bucket_id"], name: "index_items_on_tax_bucket_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "item_id", null: false
    t.integer "quantity", null: false
    t.float "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "status", default: 0, null: false
    t.decimal "total", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_orders_on_status"
  end

  create_table "tax_buckets", force: :cascade do |t|
    t.string "tax_type"
    t.decimal "tax_percentage", precision: 5, scale: 2, null: false
    t.float "tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "discounts", "items"
  add_foreign_key "discounts", "items", column: "required_item_id"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "tax_buckets"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
end
