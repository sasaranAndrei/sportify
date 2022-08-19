class SportifyAdminsController < ApplicationController
  skip_before_action :authenticate_user!
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD']

  def show
    @users = User.order(created_at: :desc)
    @new_users = User.from_last(2.days).unauthorized.pluck(:email)
  end

  def test_mailer
    SportifyAdminMailer.send_test_email.deliver!

    redirect_to sportify_admin_path
  end

  def update_user
    user = User.find(params[:user_id])
    user.update(user_params.except(:user_id))

    redirect_to sportify_admin_path
  end

  def download_arenas
    arenas = Arena.all.as_json
    arenas_file = JSON.pretty_generate(arenas)

    send_data arenas_file, filename: 'arenas.json', target: '_blank' 
  end
  
  def download_fields
    fields = Field.all.as_json
    fields_file = JSON.pretty_generate(fields)

    send_data fields_file, filename: 'fields.json', target: '_blank'
  end

  private
    def user_params
      params.permit(:user_id, :email_status)
    end
end
