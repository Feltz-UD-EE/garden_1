class CreatePins < ActiveRecord::Migration[7.0]
  def change
    create_table :pins do |t|
      t.integer     :number
      t.string      :description
      t.integer     :gpio
      t.timestamps
    end
  end
end
