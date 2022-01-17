# Inheritance
# Sensors are the general class of things can be read from an RPi pinout
# Moisture_sensors read soil moisture levels, Temp_sensors read air or soil temperature,
# Level_sensors read presence/abscense of water in a tank
#
class CreateSensors < ActiveRecord::Migration[7.0]
  def change
    create_table :sensors do |t|
      t.references  :pins
      t.timestamps
    end
    create_table :moisture_sensors do |t|
      t.references  :sensors
      t.references  :zones
      t.timestamps
    end
    create_table :temp_sensors do |t|
      t.references  :sensors
      t.references  :zones
      t.integer     :position       # enumerated list - subsoil, surface, elevated
      t.timestamps
    end
    create_table :level_sensors do |t|
      t.references  :sensors
      t.references  :tanks
      t.integer     :position       # enumerated list - top, bottom, mid  (?)
      t.timestamps
    end

  end
end
