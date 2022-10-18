# If we want to change the directory do so here
# Rails.logger = ActiveSupport::Logger.new(STDOUT)

Rails.logger = Logger.new(
  Rails.root.join(
    "log",
    'draw.log'
  ),
  'daily'
)

Rails.logger.level =
  case Rails.env
  when 'development'
    Logger::DEBUG
  when 'test'
    Logger::WARN
  when 'staging'
    Logger::WARN
  when 'production'
    Logger::ERROR
  else
    Logger::INFO
  end
