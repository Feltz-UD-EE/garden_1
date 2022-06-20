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

ActiveRecord::Schema.define(version: 2021_12_29_004430) do

  create_table "moisture_readings", force: :cascade do |t|
    t.integer "zone_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["zone_id"], name: "index_moisture_readings_on_zone_id"
  end

  create_table "tanks", force: :cascade do |t|
    t.string "name"
    t.integer "volume"
    t.integer "pump_pin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "zones", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.integer "tank_id"
    t.string "crop"
    t.string "description"
    t.integer "valve_pin"
    t.integer "sensor_pin"
    t.integer "sensor_index"
    t.integer "moisture_target"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tank_id"], name: "index_zones_on_tank_id"
  end

end
