Sidekiq.configure_server do |config|
  config.on(:startup) do
    schedule_file = "config/sidekiq.yml"

    if File.exist?(schedule_file)
      Sidekiq::Scheduler.dynamic = true
      Sidekiq.schedule = YAML.load_file(schedule_file)[:scheduler][:schedule]
      Sidekiq::Scheduler.reload_schedule!
    end
  end
end