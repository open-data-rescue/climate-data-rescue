
Raven.configure do |config|
  config.dsn = ENV.fetch("SENTRY_DSN")
  config.sanitize_fields =
    Rails.application.config.filter_parameters.map(&:to_s)
  config.processors -= [Raven::Processor::PostData] # Do this to send POST data
end
