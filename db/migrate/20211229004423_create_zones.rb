# Zones are areas that can be watered to a particular target moisture level
# A typical zone is 16-32 square feet, and usually supports one kind of plant
#
class CreateZones < ActiveRecord::Migration[7.0]
  def change
    create_table :zones do |t|
      t.string  :name
      t.string  :description
      t.float   :target_moisture        # units TBD
      t.references :tanks

      t.timestamps
    end
  end
end
