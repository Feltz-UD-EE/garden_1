#
# Copyright 2022 John C. Feltz, github: Feltz-UD-EE/garden_1
#
#
# Main asynchronous job for reading moisture levels and then activating valves/pumps appropriately
#
class MoistureReadingsJob < ActiveJob::Base
  RUN_EVERY = 15.minutes

  before_perform do |job|
    p "in before_perform, about to requeue MoistureReadingsJob"
    self.class.set(:wait => RUN_EVERY).perform_later
  end

  def perform
    p "About to run MoistureReadingsJob"
    # turn on power to moisture sensors
    Zone.moisture_sensors_activate

    # get moisture reading from MCP3108
    Zone.all.each do |zone|
      if zone.planted?
        zone.take_reading
      end
    end

    # turn off power to moisture sensors
    Zone.moisture_sensors_deactivate

    # Activate valves & pumps as necessary
    Zone.all.each do |zone|     # include non-planted so it closes valve if planted state is changed while valve was open
      if zone.needs_water
        zone.valve_open
      else
        zone.valve_close
      end
    end

    Tank.all.each do |tank|
      if tank.needs_pumping
        tank.pump_on
      else
        tank.pump_off
      end
    end
  end
end
