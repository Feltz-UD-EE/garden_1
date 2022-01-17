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

ActiveRecord::Schema.define(version: 2021_12_29_004423) do

  create_table "actuators", force: :cascade do |t|
    t.integer "pinout"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "level_sensors", force: :cascade do |t|
    t.integer "sensors_id"
    t.integer "tanks_id"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sensors_id"], name: "index_level_sensors_on_sensors_id"
    t.index ["tanks_id"], name: "index_level_sensors_on_tanks_id"
  end

  create_table "moisture_sensors", force: :cascade do |t|
    t.integer "sensors_id"
    t.integer "zones_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sensors_id"], name: "index_moisture_sensors_on_sensors_id"
    t.index ["zones_id"], name: "index_moisture_sensors_on_zones_id"
  end

  create_table "pins", force: :cascade do |t|
    t.integer "number"
    t.string "description"
    t.integer "gpio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pumps", force: :cascade do |t|
    t.integer "actuators_id"
    t.integer "tanks_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["actuators_id"], name: "index_pumps_on_actuators_id"
    t.index ["tanks_id"], name: "index_pumps_on_tanks_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.integer "pins_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pins_id"], name: "index_sensors_on_pins_id"
  end

  create_table "tanks", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.integer "backed_up_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "temp_sensors", force: :cascade do |t|
    t.integer "sensors_id"
    t.integer "zones_id"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sensors_id"], name: "index_temp_sensors_on_sensors_id"
    t.index ["zones_id"], name: "index_temp_sensors_on_zones_id"
  end

  create_table "valves", force: :cascade do |t|
    t.integer "actuators_id"
    t.integer "zones_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["actuators_id"], name: "index_valves_on_actuators_id"
    t.index ["zones_id"], name: "index_valves_on_zones_id"
  end

  create_table "zones", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "target_moisture"
    t.integer "tanks_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tanks_id"], name: "index_zones_on_tanks_id"
  end

end
