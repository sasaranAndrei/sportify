class BallsController < ApplicationController
  def new
    @ball = Ball.new
  end
  
  def create
    # TODO: Refactor!
    @ball = Ball.new(ball_params)

    return redirect_back fallback_location: sportify_coins_shop_path, notice: "You don't have enough SCoins to buy a Ball" unless current_user.can_pay?(@ball.price)

    if @ball.save
      current_user.remove_tokens!(@ball.price)

      redirect_to collection_player_path(current_user.player), notice: 'Ball was successfully purchased'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def ball_params
      params.require(:ball).permit(:color).merge(player_id: current_user.player.id)
    end
end
