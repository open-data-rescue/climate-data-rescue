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

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: :plain,
      user_name: ENV.fetch('SENDGRID_USERNAME') { '' },
      password: ENV.fetch('SENDGRID_PASSWORD') { '' },
      domain: 'heroku.com',
      enable_starttls_auto: true
    }

    # Paperclip S3 settings
    config.paperclip_defaults = {
      storage: :s3,
      s3_permissions: :public,
      s3_protocol: ENV.fetch('S3_PROTOCOL'),
      s3_host_name: ENV.fetch('S3_HOST_NAME'),
      s3_credentials: {
        access_key_id: ENV.fetch('S3_ACCESS_KEY_ID'),
        secret_access_key: ENV.fetch('S3_SECRET_ACCESS_KEY'),
        s3_region: ENV.fetch('S3_REGION'),
        bucket: ENV.fetch('S3_PRIVATE_BUCKET')
      },
      s3_options: {
        endpoint: "#{ENV.fetch('S3_PROTOCOL')}://#{ENV.fetch('S3_HOST_NAME')}",
        force_path_style: true
      },
      url: ':s3_path_url'
    }

    config.action_mailer.default_options = {
      :from   => 'draw_mcgill@outlook.com',
      :reply_to => 'draw_mcgill@outlook.com',
      :bcc => 'rsmithlal@gmail.com'
    }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true

    Rails.application.routes.default_url_options[:host] = ENV["BASE_URL"]

    config.action_mailer.default_url_options = { :host => ENV["BASE_URL"] }

  end
end
