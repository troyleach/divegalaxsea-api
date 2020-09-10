# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_712_213_349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'divings', force: :cascade do |t|
    t.string 'title'
    t.decimal 'price', precision: 8, scale: 2
    t.text 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'miscellaneous_pricings', force: :cascade do |t|
    t.string 'title'
    t.decimal 'price'
    t.text 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'rentals', force: :cascade do |t|
    t.string 'title'
    t.decimal 'price'
    t.text 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'specialties', force: :cascade do |t|
    t.string 'title'
    t.decimal 'price'
    t.text 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'trainings', force: :cascade do |t|
    t.string 'title'
    t.decimal 'price'
    t.text 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.boolean 'admin'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'vacations', force: :cascade do |t|
    t.bigint 'user_id'
    t.text 'dates_array', default: [], array: true
    t.jsonb 'diving_objects', default: {}
    t.jsonb 'training_objects', default: {}
    t.integer 'number_of_divers'
    t.string 'resort'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_vacations_on_user_id'
  end

  add_foreign_key 'vacations', 'users'
end
