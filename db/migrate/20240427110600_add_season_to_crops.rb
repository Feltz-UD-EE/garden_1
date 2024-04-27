# Full history of water level readings for all tanks
#
class CreateLevelReadings < ActiveRecord::Migration[7.0]
  def change
    add_column :crops, :season, :integer, :null => false, :default => 0
  end
end
