class CreateMoistureReadingDailySummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :moisture_reading_daily_summaries do |t|
      t.references :zone, null: false, foreign_key: true
      t.date :day, null: false
      t.integer :readings_count, null: false, default: 0
      t.integer :min_value
      t.integer :max_value
      t.float :avg_value
      t.float :stddev_value
      t.float :lower_2_sigma
      t.float :upper_2_sigma
      t.integer :low_tail_count, null: false, default: 0
      t.integer :high_tail_count, null: false, default: 0
      t.datetime :first_reading_at
      t.datetime :last_reading_at

      t.timestamps
    end

    add_index :moisture_reading_daily_summaries,
              [:zone_id, :day],
              unique: true,
              name: "idx_moisture_daily_zone_day"

    add_index :moisture_readings,
              [:created_at, :zone_id],
              name: "idx_moisture_readings_created_zone"
  end
end
