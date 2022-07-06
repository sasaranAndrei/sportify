class TshirtsController < ApplicationController
  def new
    @tshirt = Tshirt.new
  end

  def create
    @tshirt = Tshirt.new(tshirt_params)

    return redirect_back fallback_location: sportify_coins_shop_path, notice: "You don't have enough SCoins to buy a Tshirt" unless current_user.can_pay?(@tshirt.price)

    @tshirt.nickname = @tshirt.player.nickname if @tshirt.nickname.blank?
    @tshirt.number ||= 10

    if @tshirt.save
      current_user.remove_tokens!(@tshirt.price)

      redirect_to collection_player_path(current_user.player), notice: 'Tshirt was successfully purchased'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def tshirt_params
      params.require(:tshirt).permit(:color, :size, :nickname, :number).merge(player_id: current_user.player.id)
    end
end
