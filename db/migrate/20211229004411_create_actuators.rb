# Inheritance
# Actuators are the general class of things can be controlled from an RPi pinout
# Pumps are actuators that belong to tanks, Valves are actuators that belong to zones
#
class CreateActuators < ActiveRecord::Migration[7.0]
  def change
    create_table :actuators do |t|
      t.integer     :pinout
      t.timestamps
    end

    create_table :pumps do |t|
      t.references  :actuators
      t.references  :tanks
      t.boolean     :powered
      t.timestamps
    end

    create_table :valves do |t|
      t.references  :actuators
      t.references  :zones
      t.boolean     :open
      t.timestamps
    end
  end
end
