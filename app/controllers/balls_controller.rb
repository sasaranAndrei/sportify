class BallsController < ApplicationController
  def new
    @ball = Ball.new
  end
  
  def create
    @ball = Ball.new(ball_params)

    byebug
    if @ball.save
      redirect_to 
    else
    
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def ball_params
      params.require(:ball).permit(:color).merge(player_id: current_user.player.id)
    end
end
