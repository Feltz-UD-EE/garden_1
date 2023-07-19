require_relative "boot"

require "rails/all"

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
      p "starting after_initialize"

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
