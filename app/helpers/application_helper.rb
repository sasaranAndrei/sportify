# frozen_string_literal: true

module ApplicationHelper
  def current_player
    current_user.player
  end
end
