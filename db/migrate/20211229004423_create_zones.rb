# Zones are areas that can be watered to a particular target moisture level
# A typical zone is 16-32 square feet, and usually supports one kind of plant
#
class CreateZones < ActiveRecord::Migration[7.0]
  def change
    create_table :zones do |t|
      t.string  :name
      t.integer :number
      t.references :tank
      t.string  :crop
      t.string  :description
      t.integer :valve_pin
      t.integer :sensor_pin             # pin & index composite unique
      t.integer :sensor_index
      t.integer :moisture_target        # 0-1023

      t.timestamps
    end
  end
end
