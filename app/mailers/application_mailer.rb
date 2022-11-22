
class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('FROM_ADDRESS', 'draw.mcgill@gmail.com')
  layout 'mailer'
end
