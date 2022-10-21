Rails.application.config.action_mailer.tap do |action_mailer|
  action_mailer.default_options = {
    from: ENV.fetch('FROM_ADDRESS', 'draw@opendatarescue.org'),
    bcc: ENV.fetch('BCC_ADDRESS', nil)
  }

  if Rails.env.test?
    action_mailer.default_url_options = {
      host: "localhost"
    }
  elsif Rails.env.development?
    action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    action_mailer.delivery_method = :smtp
    action_mailer.perform_deliveries = true
    action_mailer.raise_delivery_errors = true
    action_mailer.smtp_settings = {
      address:              ENV.fetch("SMTP_SERVER") { 'localhost' },
      port:                 ENV.fetch("SMTP_PORT") { 1025 },
      domain:               ENV.fetch("SMTP_SERVER") { 'localhost' }
    }
  else
    # ensure that the correct portocol is used when generating emails
    protocal = Rails.application.config.force_ssl ? "https" : "http"

    action_mailer.perform_deliveries = true
    action_mailer.default_url_options = {
      host: ENV["HOSTNAME"],
      protocol: protocal
    }

    sendgrid_api_key = ENV.fetch('SENDGRID_API_KEY', '')
    if sendgrid_api_key.present?
      action_mailer.delivery_method = :sendgrid_actionmailer
      action_mailer.sendgrid_actionmailer_settings = {
        api_key: ENV.fetch('SENDGRID_API_KEY'),
        raise_delivery_errors: ENV.fetch('RAISE_EMAIL_DELIVERY_ERRORS', nil).present?
      }
    else
      action_mailer.delivery_method = :smtp
      action_mailer.smtp_settings = {
        address: ENV.fetch('SMTP_ADDRESS', 'smtp.sendgrid.net'),
        port: '587',
        authentication: :plain,
        enable_starttls_auto: true,
        user_name: ENV.fetch('SMTP_USERNAME', ''),
        password: ENV.fetch('SMTP_PASSWORD', ''),
        domain: 'opendatarescue.org'
      }
    end
  end
end