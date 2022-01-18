namespace :users do
  task :resend_confirmation => :environment do
    users = User.where.not(confirmation_token: nil)
    users.each do |user|
      user.send_confirmation_instructions
    end
  end
end
