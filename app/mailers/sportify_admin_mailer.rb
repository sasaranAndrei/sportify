class SportifyAdminMailer < ApplicationMailer
  def send_test_email
    mail to: ENV['ADMIN_EMAIL'], subject: 'Test Email'
  end

  def send_new_users_email
    new_users_count = User.from_last(2.days).unauthorized.count

    mail to: ENV['ADMIN_EMAIL'], subject: "There are #{new_users_count} new users that need authorization"
  end
end
