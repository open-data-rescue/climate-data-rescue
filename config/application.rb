require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DataRescueAtHome
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Disable asset pipeline, should all be moved to webpacker now
    config.assets.enabled = false
    config.generators { |g| g.assets false }

    if !Rails.env.test?
      config.active_job.queue_adapter = :sidekiq
    end

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

    # base URL setting
    Rails.application.routes.default_url_options[:host] = ENV["BASE_URL"]
  end
end
