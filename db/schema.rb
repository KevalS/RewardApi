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

ActiveRecord::Schema[7.0].define(version: 2022_06_04_104104) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "customer_rewards", force: :cascade do |t|
    t.bigint "reward_id", null: false
    t.bigint "customer_id", null: false
    t.bigint "transaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_rewards_on_customer_id"
    t.index ["reward_id"], name: "index_customer_rewards_on_reward_id"
    t.index ["transaction_id"], name: "index_customer_rewards_on_transaction_id"
  end

  create_table "customer_tiers", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "tier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_tiers_on_customer_id"
    t.index ["tier_id"], name: "index_customer_tiers_on_tier_id"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.date "dob", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_customers_on_client_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "loyalty_points", force: :cascade do |t|
    t.integer "points"
    t.bigint "customer_id", null: false
    t.bigint "transaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_loyalty_points_on_customer_id"
    t.index ["transaction_id"], name: "index_loyalty_points_on_transaction_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tiers", force: :cascade do |t|
    t.string "name"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.float "amount"
    t.string "description"
    t.string "country"
    t.string "currency"
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_transactions_on_customer_id"
  end

  add_foreign_key "customer_rewards", "customers"
  add_foreign_key "customer_rewards", "rewards"
  add_foreign_key "customer_rewards", "transactions"
  add_foreign_key "customer_tiers", "customers"
  add_foreign_key "customer_tiers", "tiers"
  add_foreign_key "customers", "clients"
  add_foreign_key "loyalty_points", "customers"
  add_foreign_key "loyalty_points", "transactions"
  add_foreign_key "transactions", "customers"
end
