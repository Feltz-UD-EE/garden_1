# Events are crop-specific actions, often harvesting but also notes about pruning, stacking
#   pest remediation, etc.
#
class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date    :date, default: -> { 'CURRENT_TIMESTAMP' }
      t.string  :description
      t.references :crop
      t.float   :harvest
      t.timestamps
    end
  end
end
