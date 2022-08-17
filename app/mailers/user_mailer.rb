class UserMailer < ApplicationMailer
  def send_welcome_email(user)
    @player = user.player

    mail to: @player.email, subject: 'Welcome to Sportify!'
  end
end
