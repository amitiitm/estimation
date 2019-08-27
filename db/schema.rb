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

ActiveRecord::Schema.define(version: 2019_08_27_180731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer "template_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "full_name", limit: 200
    t.string "mobile", limit: 20
    t.string "email", limit: 200
    t.string "password"
    t.string "otp"
    t.string "created_by"
    t.string "updated_by"
    t.string "department"
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "estimation_details", force: :cascade do |t|
    t.integer "estimation_id"
    t.integer "category_id"
    t.string "category_name"
    t.integer "sub_category_id"
    t.string "sub_category_name"
    t.integer "applicable"
    t.boolean "offer_flag"
    t.integer "per_component_low"
    t.integer "per_component_medium"
    t.integer "per_component_high"
    t.integer "component_low_count"
    t.integer "component_medium_count"
    t.integer "component_high_count"
    t.integer "estimated_total"
    t.integer "overridden_total"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "template_id"
    t.integer "estimation_template_id"
  end

  create_table "estimation_offers", force: :cascade do |t|
    t.integer "estimation_id"
    t.integer "category_id"
    t.string "category_name"
    t.integer "sub_category_id"
    t.string "sub_category_name"
    t.integer "hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "template_id"
    t.integer "estimation_template_id"
  end

  create_table "estimation_templates", force: :cascade do |t|
    t.integer "estimation_id"
    t.integer "template_id"
    t.text "category_ids", default: [], array: true
    t.integer "estimated_total"
    t.integer "overridden_total"
    t.boolean "offer_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reuse_factor", default: 0
    t.integer "offer_total"
    t.integer "final_hours"
  end

  create_table "estimations", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.boolean "status", default: true
    t.string "owner_email"
    t.string "notification_emails"
    t.string "followup_emails"
    t.boolean "notification_flag"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_id"
    t.integer "created_by"
    t.text "template_ids", default: [], array: true
    t.integer "complexity"
  end

  create_table "functional_scopes", force: :cascade do |t|
    t.integer "estimation_id"
    t.integer "usecase_low_count"
    t.integer "usecase_medium_count"
    t.integer "usecase_high_count"
    t.integer "ui_low_count"
    t.integer "ui_medium_count"
    t.integer "ui_high_count"
    t.integer "service_low_count"
    t.integer "service_medium_count"
    t.integer "service_high_count"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.integer "category_id"
    t.string "name"
    t.integer "hours"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "offer"
    t.string "class_name"
    t.integer "low_hours"
    t.integer "medium_hours"
    t.boolean "status", default: true
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usecases", force: :cascade do |t|
    t.integer "estimation_id"
    t.string "name"
    t.integer "ui_low_count"
    t.integer "ui_medium_count"
    t.integer "ui_high_count"
    t.integer "service_low_count"
    t.integer "service_medium_count"
    t.integer "service_high_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "complexity"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", limit: 200
    t.integer "age"
    t.integer "sex"
    t.string "mobile", limit: 20
    t.string "email", limit: 200
    t.string "password"
    t.integer "role_id"
    t.string "created_by"
    t.string "updated_by"
    t.text "skills"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
