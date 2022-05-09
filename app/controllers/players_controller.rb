class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy reservations stats]

  def reservations
    reservations = @player.all_reservations
    
    @upcoming_reservations = reservations.upcoming
    @past_reservations = reservations.past
  end

  def stats
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end
    
    def player_params
      params.require(:player).permit(:name, :nickname, :birth_date, :phone_number)
    end
end
