# disable strict args
Sidekiq.strict_args!(false)

redis_config = { url: ENV.fetch('REDIS_SIDEKIQ_URL', nil) }

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end