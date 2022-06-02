class ReservationPlayersController < ApplicationController
  before_action :set_reservation_player, only: %i[ destroy ]
  
  def destroy
    @reservation_player.cancel

    redirect_to root_path, notice: 'You have been penalized for this action!'
  end

  private
    def set_reservation_player
      @reservation_player = ReservationPlayer.find(params[:id])
    end
end
