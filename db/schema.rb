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

ActiveRecord::Schema.define(version: 20180922100052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hash_tags", force: :cascade do |t|
    t.string "hash_tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hash_tags_notes", force: :cascade do |t|
    t.bigint "hash_tag_id"
    t.bigint "note_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hash_tag_id"], name: "index_hash_tags_notes_on_hash_tag_id"
    t.index ["note_id"], name: "index_hash_tags_notes_on_note_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "hash_tags_notes", "hash_tags"
  add_foreign_key "hash_tags_notes", "notes"
end
