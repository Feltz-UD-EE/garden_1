class CreateMoistureReadingDailySummaryCrops < ActiveRecord::Migration[7.0]
  def change
    create_table :moisture_reading_daily_summary_crops do |t|
      t.references :moisture_reading_daily_summary,
                   null: false,
                   foreign_key: true,
                   index: { name: "idx_moisture_summary_crop_summary" }
      t.references :crop,
                   null: false,
                   foreign_key: true,
                   index: { name: "idx_moisture_summary_crop_crop" }

      t.timestamps
    end

    add_index :moisture_reading_daily_summary_crops,
              [:moisture_reading_daily_summary_id, :crop_id],
              unique: true,
              name: "idx_moisture_summary_crop_unique"
  end
end
