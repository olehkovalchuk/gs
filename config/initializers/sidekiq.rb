REDIS_URL = "redis://#{Rails.application.secrets[:redis][:host]}:#{Rails.application.secrets[:redis][:port]}/0"
# SIDEKIQ_NAMESPACE     = "be_one-global-supplies-#{Rails.env}"
SIDEKIQ_NAMESPACE     = "global-supplies-#{Rails.env}"
SIDEKIQ_CLIENT_CONFIG = { url: REDIS_URL, namespace: SIDEKIQ_NAMESPACE, size: 1 }
SIDEKIQ_SERVER_CONFIG = { url: REDIS_URL, namespace: SIDEKIQ_NAMESPACE, size: 60 }

Sidekiq.configure_client do |config|
  config.redis = SIDEKIQ_CLIENT_CONFIG

  # config.client_middleware do |chain|
  #   chain.add SidekiqClientMiddleware
  # end

end
Sidekiq.configure_server do |config|
  config.redis = SIDEKIQ_SERVER_CONFIG

  # config.server_middleware do |chain|
  #   chain.add RequestStoreMiddleware
  # end
  config.average_scheduled_poll_interval = 2
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../schedule.yml', __FILE__))[Rails.env]
    Sidekiq::Scheduler.reload_schedule!
  end

end
