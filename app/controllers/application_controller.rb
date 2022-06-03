# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_sanitized_params, if: :devise_controller?
  before_action :authenticate_user!

  protected

    def configure_sanitized_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [player_attributes: [:name, :nickname, :birth_date, :phone_number]])
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, player_attributes: [:id, :name, :nickname, :phone_number]])
    end
end
