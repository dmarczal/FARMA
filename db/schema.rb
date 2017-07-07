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

ActiveRecord::Schema.define(version: 20170629021913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_researches", force: :cascade do |t|
    t.string   "title"
    t.text     "ref"
    t.text     "abstract"
    t.string   "link"
    t.string   "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "answers", force: :cascade do |t|
    t.text     "response"
    t.boolean  "correct"
    t.integer  "attempt_number"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "team_id"
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "title",           null: false
    t.text     "content",         null: false
    t.integer  "position"
    t.integer  "questions_count"
    t.integer  "lo_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "exercises_tags", id: false, force: :cascade do |t|
    t.integer "tag_id",      null: false
    t.integer "exercise_id", null: false
  end

  create_table "introductions", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.integer  "position"
    t.integer  "lo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "introductions_tags", id: false, force: :cascade do |t|
    t.integer "tag_id",          null: false
    t.integer "introduction_id", null: false
  end

  create_table "los", force: :cascade do |t|
    t.string   "name",                default: "", null: false
    t.text     "description",         default: "", null: false
    t.integer  "introductions_count", default: 0
    t.integer  "exercises_count",     default: 0
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "los_tags", id: false, force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "lo_id",  null: false
  end

  create_table "los_teams", force: :cascade do |t|
    t.integer  "lo_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lo_id"], name: "index_los_teams_on_lo_id", using: :btree
    t.index ["team_id"], name: "index_los_teams_on_team_id", using: :btree
  end

  create_table "progress_exercises", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.float    "progress_percent", default: 0.0
    t.float    "preview_percent",  default: 0.0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["exercise_id"], name: "index_progress_exercises_on_exercise_id", using: :btree
    t.index ["team_id"], name: "index_progress_exercises_on_team_id", using: :btree
    t.index ["user_id"], name: "index_progress_exercises_on_user_id", using: :btree
  end

  create_table "progress_introductions", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "introduction_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["introduction_id"], name: "index_progress_introductions_on_introduction_id", using: :btree
    t.index ["team_id"], name: "index_progress_introductions_on_team_id", using: :btree
    t.index ["user_id"], name: "index_progress_introductions_on_user_id", using: :btree
  end

  create_table "progress_los", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "lo_id"
    t.float    "progress_percent", default: 0.0
    t.float    "preview_percent",  default: 0.0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["lo_id"], name: "index_progress_los_on_lo_id", using: :btree
    t.index ["team_id"], name: "index_progress_los_on_team_id", using: :btree
    t.index ["user_id"], name: "index_progress_los_on_user_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title",          null: false
    t.integer  "position"
    t.text     "content",        null: false
    t.text     "correct_answer", null: false
    t.integer  "precision"
    t.boolean  "cmas_order"
    t.integer  "exercise_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "opened"
    t.index ["user_id"], name: "index_teams_on_user_id", using: :btree
  end

  create_table "tips", force: :cascade do |t|
    t.text     "content",                     null: false
    t.integer  "question_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "number_of_tries", default: 1
  end

  create_table "tips_counts", force: :cascade do |t|
    t.integer  "tries"
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_tips_counts_on_question_id", using: :btree
    t.index ["team_id"], name: "index_tips_counts_on_team_id", using: :btree
    t.index ["user_id"], name: "index_tips_counts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_teams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_users_teams_on_team_id", using: :btree
    t.index ["user_id"], name: "index_users_teams_on_user_id", using: :btree
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "teams"
  add_foreign_key "answers", "users"
  add_foreign_key "los_teams", "los"
  add_foreign_key "los_teams", "teams"
  add_foreign_key "progress_exercises", "exercises"
  add_foreign_key "progress_exercises", "teams"
  add_foreign_key "progress_exercises", "users"
  add_foreign_key "progress_introductions", "introductions"
  add_foreign_key "progress_introductions", "teams"
  add_foreign_key "progress_introductions", "users"
  add_foreign_key "progress_los", "los"
  add_foreign_key "progress_los", "teams"
  add_foreign_key "progress_los", "users"
  add_foreign_key "teams", "users"
  add_foreign_key "tips_counts", "questions"
  add_foreign_key "tips_counts", "teams"
  add_foreign_key "tips_counts", "users"
  add_foreign_key "users_teams", "teams"
  add_foreign_key "users_teams", "users"
end
