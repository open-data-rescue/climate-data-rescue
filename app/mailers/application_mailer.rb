
class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('FROM_ADDRESS', 'draw@opendatarescue.org')
  layout 'mailer'
end
