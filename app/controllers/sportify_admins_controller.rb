class SportifyAdminsController < ApplicationController
  skip_before_action :authenticate_user!
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD']

  def show
  end

  def test_mailer
    SportifyAdminMailer.send_test_email.deliver!

    redirect_to sportify_admin_path
  end
end
