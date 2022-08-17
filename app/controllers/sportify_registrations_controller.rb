class SportifyRegistrationsController < Devise::RegistrationsController
  def create
    super

    UserMailer.send_welcome_email(@user).deliver! if @user.persisted?
  end
end
