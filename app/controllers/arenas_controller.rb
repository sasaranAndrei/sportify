class ArenasController < ApplicationController
  before_action :set_arena, only: %i[ show ]
  skip_before_action :authenticate_user!

  def index
    @arenas = Arena.all
  end

  def show
  end

  private
    def set_arena
      @arena = Arena.find(params[:id])
    end

    # def arena_params
    #   params.require(:arena).permit(:title, :location, :phone_number, :latitude, :longitude)
    # end
end
