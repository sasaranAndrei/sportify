class ReservationPlayersController < ApplicationController
  before_action :set_reservation_player, only: %i[ destroy ]
  
  def destroy
    byebug
    @reservation_player.cancel

    redirect_back(fallback_location: reservations_player_path(current_user.player), notice: 'You have been penalized for this action!')
  end

  private
    def set_reservation_player
      @reservation_player = ReservationPlayer.find(params[:id])
    end
end
