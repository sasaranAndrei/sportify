class SportifyAdminMailer < ApplicationMailer
  def send_test_email
    mail to: ENV['ADMIN_EMAIL'], subject: 'Test Email'
  end
end
