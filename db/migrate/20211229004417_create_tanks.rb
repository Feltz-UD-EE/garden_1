class CreateTanks < ActiveRecord::Migration[7.0]
  def change
    create_table :tanks do |t|
      t.string  :name
      t.integer :volume               # liters
      t.integer :pump_pin
      t.timestamps
    end
  end
end
