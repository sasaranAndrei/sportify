class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy reservations stats join_requests]

  def reservations
    reservations = @player.all_reservations
    
    @upcoming_reservations = reservations.upcoming
    @past_reservations = reservations.past
  end

  def stats
  end

  def join_requests
    @guest_join_requests = @player.guest_join_requests
    @own_join_requests = @player.join_requests
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end
    
    def player_params
      params.require(:player).permit(:name, :nickname, :birth_date, :phone_number)
    end
end
