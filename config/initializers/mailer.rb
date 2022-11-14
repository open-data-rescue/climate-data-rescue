Rails.application.config.action_mailer.tap do |action_mailer|
  action_mailer.default_options = {
    from: ENV.fetch('FROM_ADDRESS', 'draw.mcgill@gmail.com'),
    bcc: ENV.fetch('BCC_ADDRESS', nil)
  }

  if Rails.env.test?
    action_mailer.default_url_options = { host: "localhost" }
  elsif Rails.env.development?
    action_mailer.tap do |action_mailer|
      action_mailer.default_url_options = { host: 'localhost', port: 3000 }
      action_mailer.delivery_method = :smtp
      action_mailer.perform_deliveries = true
      action_mailer.raise_delivery_errors = true
      action_mailer.smtp_settings = {
        address:              ENV.fetch("SMTP_SERVER") { 'localhost' },
        port:                 ENV.fetch("SMTP_PORT") { 1025 },
        domain:               ENV.fetch("SMTP_SERVER") { 'localhost' }
      }
    end
  else
    # ensure that the correct portocol is used when generating emails
    protocal = Rails.application.config.force_ssl ? "https" : "http"

    action_mailer.tap do |action_mailer|
      action_mailer.default_url_options = { host: ENV["HOSTNAME"], protocol: protocal }
      action_mailer.delivery_method = :smtp
      action_mailer.perform_deliveries = true
      action_mailer.raise_delivery_errors = true
      action_mailer.smtp_settings = {
        authentication: :plain,
        enable_starttls_auto: true,
        address: ENV.fetch('SMTP_SERVER', 'smtp.gmail.com'),
        port: ENV.fetch("SMTP_PORT") { 587 },
        user_name: ENV.fetch('SMTP_USERNAME', ''),
        password: ENV.fetch('SMTP_PASSWORD', ''),
        domain: ENV.fetch('SMTP_DOMAIN', 'gmail.com')
      }
    end
  end
end
