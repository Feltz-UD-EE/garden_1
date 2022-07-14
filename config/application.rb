require_relative "boot"

require "rails/all"
require 'rpi_gpio'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Garden1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.after_initialize do
      RPi::GPIO.set_numbering :bcm
      # Initialize RPi pins
#         RPi::GPIO.setup Zone::SensorMultiplexClockPin, :as => :output
#         RPi::GPIO.setup Zone::SensorMultiplexAddressingPin, :as => :output
#         RPi::GPIO.setup Zone::SensorPowerPin, :as => :output
      Tank.all.each do |tank|
        RPi::GPIO.setup tank.pump_pin, :as => :output
      end
      Zone.all.each do |zone|
        RPi::GPIO.setup zone.valve_pin, :as => :output
#         RPi::GPIO.setup zone.sensor_pin, :as => :input
      end

      # Queue up initial job
      now = Time.now
      nearest_hour = now.beginning_of_hour
      interval = MoistureReadingsJob::RUN_EVERY
      moddiff = (now - nearest_hour) % interval
      delta = interval - moddiff
      start = (now + delta).round(0)
      p "calculated the stuff for the first instance of the MoistureReadingsJob.  Start time = #{start}"
      MoistureReadingsJob.set(wait_until: start).perform_later

    end
  end
end
