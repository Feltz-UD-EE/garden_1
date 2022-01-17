class CreateTanks < ActiveRecord::Migration[7.0]
  def change
    create_table :tanks do |t|
      t.string  :name
      t.integer :capacity               # liters
      t.integer :backed_up_by           # self-reference

      t.timestamps
    end
  end
end
