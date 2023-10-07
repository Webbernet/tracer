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

ActiveRecord::Schema[7.0].define(version: 2023_10_07_054552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audit_tables", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.string "auditable_type"
    t.bigint "auditable_id"
    t.boolean "system_event", default: false, null: false
    t.string "event_name"
    t.jsonb "metadata", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditable_type", "auditable_id"], name: "index_audit_tables_on_auditable"
    t.index ["user_type", "user_id"], name: "index_audit_tables_on_user"
  end

  create_table "tracer_audit_notifications", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "event_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
