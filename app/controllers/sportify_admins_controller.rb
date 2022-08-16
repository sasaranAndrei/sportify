class SportifyAdminsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
  end

  def test_mailer
    SportifyAdminMailer.send_test_email.deliver!

    head :ok
  end
end
