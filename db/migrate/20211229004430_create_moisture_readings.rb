# Full history of moisture readings for all zones
#
class CreateMoistureReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :moisture_readings do |t|
      t.references :zone
      t.integer :readings               # 0-1023

      t.timestamps
    end
  end
end
