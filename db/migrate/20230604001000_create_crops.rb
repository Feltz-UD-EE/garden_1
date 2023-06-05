# Crops are planted in zones - water levels are set by zone, so two crops in the
#   zone should have similar moisture needs
#
class CreateCrops < ActiveRecord::Migration[7.0]
  def change
    create_table :crops do |t|
      t.string  :name
      t.string  :description
      t.references :zone
      t.date    :plant_date
      t.date    :pull_date
      t.timestamps
    end

    remove_column :zones, :crop
  end
end
