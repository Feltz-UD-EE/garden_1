# DB getting overloaded with old data
# eventually do this automatically in a cron, or have a button on an admin page or something
#
class DeleteOldMoistureReadings2021 < ActiveRecord::Migration[7.0]
  def change
    readings = MoistureReading.where("created_at < '2022-01-01'")
    readings.each do |reading|
      reading.destroy
    end
  end
end
