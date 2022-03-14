class ArenasController < ApplicationController
  before_action :set_arena, only: %i[ show edit update destroy ]

  # GET /arenas or /arenas.json
  def index
    @arenas = Arena.all
  end

  # GET /arenas/1 or /arenas/1.json
  def show
  end

  # GET /arenas/new
  def new
    @arena = Arena.new
  end

  # GET /arenas/1/edit
  def edit
  end

  # POST /arenas or /arenas.json
  def create
    @arena = Arena.new(arena_params)

    respond_to do |format|
      if @arena.save
        format.html { redirect_to arena_url(@arena), notice: "Arena was successfully created." }
        format.json { render :show, status: :created, location: @arena }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @arena.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arenas/1 or /arenas/1.json
  def update
    respond_to do |format|
      if @arena.update(arena_params)
        format.html { redirect_to arena_url(@arena), notice: "Arena was successfully updated." }
        format.json { render :show, status: :ok, location: @arena }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @arena.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arenas/1 or /arenas/1.json
  def destroy
    @arena.destroy

    respond_to do |format|
      format.html { redirect_to arenas_url, notice: "Arena was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arena
      @arena = Arena.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def arena_params
      params.require(:arena).permit(:title, :location, :phone_number)
    end
end
