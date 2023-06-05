# Full history of water level readings for all tanks
#
class CreateLevelReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :level_readings do |t|
      t.references :tank
      t.boolean :low             # binary sensors

      t.timestamps
    end
  end
end
