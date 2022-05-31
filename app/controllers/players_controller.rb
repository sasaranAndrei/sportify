class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy reservations stats collection join_requests ]

  def reservations
    reservations = @player.all_reservations
    
    @upcoming_reservations = reservations.upcoming.ordered(:asc)
    @past_reservations = reservations.past.ordered(:asc)
  end

  def stats
    @rating_chart_data = @player.own_reviews
                                .group_by(&:reservation_id)
                                .transform_keys { |reservation_id| Reservation.find(reservation_id).display_datetime(:chart) }
                                .transform_values { |reviews| reviews.map(&:rating).sum.to_f / reviews.count }

    @reservations_chart_data = {
      'Own Reservations': @player.own_reservations.count,
      'Guest Reservations': @player.guest_reservations.count
    }
  end

  def join_requests
    @guest_join_requests = @player.guest_join_requests
    @own_join_requests = @player.join_requests
  end

  def collection
    @items = @player.tshirts + @player.balls
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end
    
    def player_params
      params.require(:player).permit(:name, :nickname, :birth_date, :phone_number)
    end
end
