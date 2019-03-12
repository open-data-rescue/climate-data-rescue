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
        :address        => 'smtp.office365.com',
        :port           => '587',
        :authentication => :login,
        :user_name      => ENV['SMTP_USERNAME'],
        :password       => ENV['SMTP_PASSWORD'],
        :domain         => 'outlook.com',
        :enable_starttls_auto => true
    }

    config.action_mailer.default_options = {
        :from   => 'draw_mcgill@outlook.com',
        :reply_to => 'draw_mcgill@outlook.com',
        :bcc => 'robert@grenadine.co'
    }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true

    Rails.application.routes.default_url_options[:host] = ENV["BASE_URL"]

    config.action_mailer.default_url_options = { :host => ENV["BASE_URL"] }

  end
end
