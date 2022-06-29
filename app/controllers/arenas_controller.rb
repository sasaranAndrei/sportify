class ArenasController < ApplicationController
  before_action :set_arena, only: %i[ show update ]
  skip_before_action :authenticate_user!

  def index
    @arenas = Arena.all
  end

  def show
  end

  # TODO: remove this functionality
  def update
    byebug
    if @arena.update(arena_params)
      redirect_to arena_path(@arena), notice: 'Photo successfully attached to this arena!'
    else
      render :show
    end
  end

  private
    def set_arena
      @arena = Arena.find(params[:id])
    end

    def arena_params
      params.require(:arena).permit(:title, :location, :phone_number, :latitude, :longitude, :photo)
    end
end
