class AddChildrenToTanks < ActiveRecord::Migration[7.0]
  def change
    add_column :tanks, :child_id, :integer
  end
end
