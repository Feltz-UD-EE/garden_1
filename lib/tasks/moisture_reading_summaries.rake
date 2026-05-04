namespace :moisture_readings do
  desc "Summarize completed calendar years of moisture readings and prune raw rows"
  task summarize_previous_years: :environment do
    max_days = ENV.fetch("MAX_DAYS", 7).to_i
    sleep_seconds = ENV.fetch("SLEEP_SECONDS", 0.5).to_f
    as_of = ENV["AS_OF"].present? ? Date.parse(ENV["AS_OF"]) : Date.current

    summarized_days = MoistureReadingSummariesJob.perform_now(
      as_of: as_of,
      max_days: max_days,
      sleep_seconds: sleep_seconds
    )

    puts "Summarized #{summarized_days} day#{'s' unless summarized_days == 1} of moisture readings."
  end

  desc "Catch up completed calendar year moisture summaries until caught up or runtime limit is reached"
  task catch_up_previous_years: :environment do
    max_runtime_minutes = ENV.fetch("MAX_RUNTIME_MINUTES", 30).to_i
    sleep_seconds = ENV.fetch("SLEEP_SECONDS", 1.0).to_f
    as_of = ENV["AS_OF"].present? ? Date.parse(ENV["AS_OF"]) : Date.current

    summarized_days = MoistureReadingSummariesJob.catch_up(
      as_of: as_of,
      max_runtime: max_runtime_minutes.minutes,
      sleep_seconds: sleep_seconds
    )

    puts "Catch-up summarized #{summarized_days} day#{'s' unless summarized_days == 1} of moisture readings."
  end
end
