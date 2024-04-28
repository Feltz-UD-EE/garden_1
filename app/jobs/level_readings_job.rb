#
# Copyright 2022-2023 John C. Feltz, github: Feltz-UD-EE/garden_1
#
#
# Main asynchronous job for reading tank levels and then activating valves/pumps appropriately
# Eventually extend to include SMS alerts
#
class LevelReadingsJob < ActiveJob::Base
  RUN_EVERY = 15.minutes

  before_perform do |job|
    p "in before_perform, about to requeue LevelReadingsJob"
    now = Time.now
    nearest_hour = now.beginning_of_hour
    interval = LevelReadingsJob::RUN_EVERY
    moddiff = (now - nearest_hour) % interval
    delta = interval - moddiff
    start = (now + delta).round(0)
    p "Next LevelReadingsJob will start at #{start}"
    self.class.set(wait_until: start).perform_later
  end

  def perform
    p "About to run LevelReadingsJob"

    # get level reading from MCP3108
    Tank.all.each do |tank|
      tank.take_reading
    end

    # Activate parent tank pumps as necessary
    Tank.all.each do |tank|
      if tank.parent_tank.present?
        if tank.low_level
          tank.parent_tank.pump_on
        else
          tank.praent_tank.pump_off
        end
      end
    end
  end
end
