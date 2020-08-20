
class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user

    mail(to: user.email)
  end
end
