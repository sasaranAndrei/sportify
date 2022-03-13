# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_sanitized_params, if: :devise_controller?

  protected

    def configure_sanitized_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [player_attributes: [:name, :nickname, :birth_date, :phone_number]])
    end
end
