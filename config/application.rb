require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DataRescueAtHome
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    config.time_zone = "Eastern Time (US & Canada)"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.i18n.fallbacks = [I18n.default_locale]

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_fieldgroups_in_json = true

    config.assets.paths << Rails.root.join("vendor", "assets", "images", "plugins")
    config.assets.precompile += %w( trombowyg/icons.svg transcriber_app.js snowEffect.js )

    sendgrid_api_key = ENV.fetch('SENDGRID_API_KEY', '')
    if sendgrid_api_key.present?
      config.action_mailer.delivery_method = :sendgrid_actionmailer
      config.action_mailer.sendgrid_actionmailer_settings = {
        api_key: ENV.fetch('SENDGRID_API_KEY'),
        raise_delivery_errors: ENV.fetch('RAISE_EMAIL_DELIVERY_ERRORS', nil).present?
      }
    else
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = {
        address: ENV.fetch('SMTP_ADDRESS', 'smtp.sendgrid.net'),
        port: '587',
        authentication: :plain,
        enable_starttls_auto: true,
        user_name: ENV.fetch('SMTP_USERNAME', ''),
        password: ENV.fetch('SMTP_PASSWORD', ''),
        domain: 'opendatarescue.org'
      }
    end

    config.action_mailer.default_options = {
      from: ENV.fetch('FROM_ADDRESS', 'draw@opendatarescue.org'),
      bcc: ENV.fetch('BCC_ADDRESS', nil)
    }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = ENV.fetch('RAISE_EMAIL_DELIVERY_ERRORS', nil).present?

    # base URL setting
    Rails.application.routes.default_url_options[:host] = ENV["BASE_URL"]
    config.action_mailer.default_url_options = { host: ENV["BASE_URL"] }
  end
end
