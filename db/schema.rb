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

ActiveRecord::Schema.define(version: 20170110205044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "super_admin",            default: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree
  end

  create_table "facts", force: :cascade do |t|
    t.string   "headline"
    t.string   "line_one"
    t.string   "line_two"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position",   default: 0
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.boolean  "visible",    default: true
    t.boolean  "private",    default: false
    t.string   "permalink"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["permalink"], name: "index_pages_on_permalink", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "permalink"
    t.integer  "position",   default: 0
    t.text     "content"
    t.boolean  "visible",    default: true
    t.boolean  "private",    default: false
    t.string   "image"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name"
    t.index ["page_id"], name: "index_sections_on_page_id", using: :btree
    t.index ["permalink"], name: "index_sections_on_permalink", using: :btree
  end

  create_table "storages", force: :cascade do |t|
    t.string   "first_adv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temp_data", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "email"
    t.string   "phone"
    t.string   "street1"
    t.string   "street2"
    t.string   "zipcode"
    t.string   "member_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "content"
  end

  create_table "testimonials", force: :cascade do |t|
    t.string   "image"
    t.string   "author"
    t.string   "content"
    t.string   "css_bottom"
    t.string   "css_left"
    t.string   "testimonial_type"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "position",         default: 0
  end

  create_table "videos", force: :cascade do |t|
    t.string   "hyperlink"
    t.string   "position"
    t.string   "link_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_videos_on_position", using: :btree
  end

  add_foreign_key "sections", "pages"
end
