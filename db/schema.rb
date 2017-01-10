# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150424161201) do

  create_table "accountants", force: true do |t|
    t.integer  "department_id"
    t.string   "name",            limit: 100
    t.string   "email",                       default: "", null: false
    t.string   "password",        limit: 40
    t.string   "address",         limit: 100
    t.string   "postcode",        limit: 10
    t.string   "phone",           limit: 20
    t.string   "gender",          limit: 6
    t.string   "password_digest",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
    t.string   "username",        limit: 20,               null: false
    t.string   "name",            limit: 100
    t.string   "email",                       default: "", null: false
    t.string   "department",      limit: 50
    t.string   "address",         limit: 100
    t.string   "phone",           limit: 20
    t.string   "password_digest",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", force: true do |t|
    t.string   "title",      limit: 100, null: false
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.date     "date",                   null: false
    t.datetime "start"
    t.datetime "end"
    t.string   "allDay",     limit: 50,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appointments", ["patient_id", "doctor_id"], name: "index_appointments_on_patient_id_and_doctor_id", using: :btree

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bedallotments", force: true do |t|
    t.integer  "bed_id"
    t.integer  "nurse_id"
    t.integer  "doctor_id"
    t.string   "alloted_by",    limit: 100, null: false
    t.integer  "patient_id"
    t.integer  "bednumber"
    t.date     "allotmentdate"
    t.date     "dischargedate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beds", force: true do |t|
    t.integer  "nurse_id"
    t.integer  "bednumber"
    t.string   "wardtype",     limit: 50
    t.string   "wardcategory", limit: 50
    t.decimal  "dailyrate",               precision: 10, scale: 2
    t.decimal  "deposit",                 precision: 11, scale: 2
    t.text     "description"
    t.string   "status",       limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.integer  "admin_id"
    t.string   "name",        limit: 100
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", force: true do |t|
    t.integer  "department_id"
    t.string   "name",            limit: 100
    t.string   "email",                       default: "", null: false
    t.string   "address",         limit: 100
    t.string   "phone",           limit: 20
    t.string   "gender",          limit: 6
    t.string   "postcode",        limit: 10,               null: false
    t.text     "profile"
    t.string   "password_digest",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospitals", force: true do |t|
    t.string   "hospitalname", limit: 100
    t.integer  "adminid"
    t.string   "systemname",   limit: 100
    t.string   "email",                    default: "", null: false
    t.string   "address",      limit: 100
    t.string   "phone",        limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labtechnicians", force: true do |t|
    t.integer  "department_id"
    t.string   "name",            limit: 100
    t.string   "email",                       default: "", null: false
    t.string   "password",        limit: 40
    t.string   "address",         limit: 100
    t.string   "postcode",        limit: 10
    t.string   "phone",           limit: 20
    t.string   "gender",          limit: 6
    t.text     "profile"
    t.string   "password_digest",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nurses", force: true do |t|
    t.integer  "department_id",                            null: false
    t.string   "name",            limit: 100
    t.string   "email",                       default: "", null: false
    t.string   "postcode",        limit: 10,               null: false
    t.string   "address",         limit: 100
    t.string   "phone",           limit: 20
    t.string   "gender",          limit: 6
    t.string   "specialty",       limit: 50
    t.string   "password_digest",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string   "name",          limit: 100
    t.string   "email",                     default: "", null: false
    t.string   "address",       limit: 200
    t.string   "postcode",      limit: 10,               null: false
    t.string   "phone",         limit: 20
    t.string   "gender",        limit: 6
    t.string   "bloodgroup",    limit: 5
    t.date     "dateofbirth",                            null: false
    t.string   "maritalstatus", limit: 20
    t.string   "occupation",    limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pharmacists", force: true do |t|
    t.integer  "department_id"
    t.string   "name",            limit: 100
    t.string   "email",                       default: "", null: false
    t.string   "password",        limit: 40
    t.string   "address",         limit: 100
    t.string   "postcode",        limit: 10
    t.string   "phone",           limit: 20
    t.string   "gender",          limit: 6
    t.text     "profile",                                  null: false
    t.string   "password_digest",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.integer  "admin_id"
    t.integer  "doctor_id"
    t.integer  "nurse_id"
    t.integer  "pharmacist_id"
    t.integer  "lab_technician_id"
    t.integer  "accountant_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
