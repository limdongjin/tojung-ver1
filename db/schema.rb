# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180409034540) do

  create_table "vcarts", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.text "package_name"
    t.integer "num"
    t.integer "addhoo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "package_id"
  end

  create_table "vpackages", force: :cascade do |t|
    t.integer "product_id"
    t.text "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vproducts", force: :cascade do |t|
    t.integer "bill_id"
    t.integer "fake_price"
    t.integer "price"
    t.text "main_image_link"
    t.integer "total_buy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "title"
    t.text "intro"
    t.integer "deadline"
    t.integer "seller_id"
  end

  create_table "vsellers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "account"
    t.text "account_assos"
  end

  create_table "vtransactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.integer "price"
    t.integer "total_amount"
    t.integer "num"
    t.integer "flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "serial"
    t.integer "package_price"
    t.integer "package_num"
    t.integer "hoo"
    t.integer "user_account"
    t.text "baesong_name"
    t.text "baesong_addr"
    t.integer "baesong_addr_num"
    t.text "baesong_contact"
    t.text "payment_way"
    t.boolean "ispay"
    t.integer "received_amount"
    t.text "baesong_status"
    t.text "user_name"
    t.text "user_phone"
    t.text "user_email"
    t.integer "user_addr_num"
    t.text "user_addr"
  end

  create_table "vusers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "name"
    t.text "address"
    t.text "account"
    t.text "phone_number"
    t.text "account_assos"
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_day"
    t.integer "address_num"
    t.index ["email"], name: "index_vusers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_vusers_on_reset_password_token", unique: true
  end

end
