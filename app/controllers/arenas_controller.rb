class ArenasController < ApplicationController
  before_action :set_arena, only: %i[ show update ]
  before_action :check_admin, except: %i[ show index ]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @arenas = Arena.all
  end

  def show
  end

  # ADMIN
  def new
    @arena = Arena.new
  end

  def create
    @arena = Arena.new(arena_params)

    if @arena.save
      redirect_to arena_path(@arena), notice: "Arena was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
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

    def check_admin
      return redirect_to root_path if current_user.email != 'sasaranandreipaul@gmail.com'
    end
end
