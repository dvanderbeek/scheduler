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

ActiveRecord::Schema.define(version: 20160403202627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_schedules", force: :cascade do |t|
    t.integer  "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "payment_schedules", ["loan_id"], name: "index_payment_schedules_on_loan_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.date     "date"
    t.integer  "payment_schedule_id"
    t.integer  "amount_due_cents"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "amount_cents"
  end

  add_index "payments", ["date"], name: "index_payments_on_date", using: :btree
  add_index "payments", ["payment_schedule_id"], name: "index_payments_on_payment_schedule_id", using: :btree

  add_foreign_key "payment_schedules", "loans"
  add_foreign_key "payments", "payment_schedules"

  create_view :latest_schedules,  sql_definition: <<-SQL
      SELECT DISTINCT ON (payment_schedules.loan_id) payment_schedules.id, payment_schedules.loan_id, payment_schedules.created_at, payment_schedules.updated_at FROM payment_schedules ORDER BY payment_schedules.loan_id, payment_schedules.created_at DESC;
  SQL

end
