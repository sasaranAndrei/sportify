class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # if owner_player => my reservations else => available reservations (marketplace)
  def index
    if params[:owner_player_id].blank?
      @reservations = Reservation.all
      # @reservations = Reservation.all # la un moment dat AvailableReservationsService.call // cv din ReservationManager
    else
      owner_player = Player.find(params[:owner_player_id])
      
      @reservations = owner_player.all_reservations
      @upcoming_reservations = @reservations.upcoming
      @past_reservations = @reservations.past
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    return redirect_to arenas_path, notice: 'Please select an Arena before create a Reservation' if params[:arena_id].blank?

    @arena = Arena.find(params[:arena_id])
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(
      reservation_params.merge(params.permit(
        :owner_player_id,
        :field_id
        )
      )
    )

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservation_url(@reservation), notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def reservation_params
      # params.fetch(:reservation, {})
      params.require(:reservation).permit(:booking_date, :booking_hour, :owner_player_id, :arena_id, :field_id)
    end

    def merge_params
      reservation_params.merge({
        # owner_player_id: params[:owner_player_id],
      })
    end
  end
