class SportifyAdminMailer < ApplicationMailer
  def send_test_email
    # TODO: put this into SportifyConfig singleton DB object // ENV
    mail to: 'sasaranandreipaul@gmail.com', subject: "Test Email"
  end
end
