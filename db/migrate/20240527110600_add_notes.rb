# general notes about the garden as a whole
#
class AddNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.date    :date, default: -> { 'CURRENT_TIMESTAMP' }
      t.text    :description
      t.timestamps
    end
  end
end
