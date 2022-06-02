class JoinRequestsController < ApplicationController
  before_action :set_join_request, only: %i[ show edit update destroy approve decline ]
  before_action :set_reservation_info, only: %i[ new create ]
  before_action :find_join_request, only: %i[ new ]

  # GET /join_requests or /join_requests.json
  def index
    @join_requests = JoinRequest.all
  end

  # GET /join_requests/1 or /join_requests/1.json
  def show
  end

  # GET /join_requests/new
  def new
    return redirect_to reservations_path, notice: 'You selected an own Reservation. Please select another Reservation to join' if params[:player_id] == @reservation.owner_player_id
    return redirect_to join_request_path(@join_request), notice: 'You already created a Join Request for this reservation. This is you Join Request' if @join_request

    @join_request = JoinRequest.new
  end

  # GET /join_requests/1/edit
  def edit
    current_player = current_user.player # TODO: refactor this

    @reservation = @join_request.reservation
    @owner_player = @reservation.owner_player
    @reservation_player = ReservationPlayer.find_by(reservation_id: @reservation.id, player_id: current_player.id)
  end

  # POST /join_requests or /join_requests.json
  def create
    @join_request = JoinRequest.new(join_request_params)

    if @join_request.save
      redirect_to edit_join_request_path(@join_request), notice: "Join request was successfully created." 
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /join_requests/1 or /join_requests/1.json
  def update
    respond_to do |format|
      if @join_request.update(join_request_params)
        format.html { redirect_to join_request_url(@join_request), notice: "Join request was successfully updated." }
        format.json { render :show, status: :ok, location: @join_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @join_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    @join_request.update(approved: true)
    # TechQuestion - how to remove dependency with ReservatinoPlayer
    ReservationPlayer.find_or_create_by!(
      reservation_id: @join_request.reservation_id,
      player_id: @join_request.player_id,
      joined_by: ReservationPlayer::JOIN_REQUEST
    ) 
    
    redirect_to join_requests_player_path(current_user.player) # TODO: check why current_player is not visible
  end
  
  def decline
    @join_request.update(approved: false)
    # TechQuestion - how to remove dependency with ReservatinoPlayer
    ReservationPlayer.find_by(reservation_id: @join_request.reservation_id, player_id: @join_request.player_id)&.destroy

    redirect_to join_requests_player_path(current_user.player) # TODO: check why current_player is not visible
  end

  # DELETE /join_requests/1 or /join_requests/1.json
  def destroy
    @join_request.destroy

    redirect_to reservations_player_path(current_user.player)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_join_request
      @join_request = JoinRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def join_request_params
      params.require(:join_request).permit(:player_id, :reservation_id, :joined_by)
    end

    def set_reservation_info
      @reservation = Reservation.find(params[:reservation_id] || params[:join_request][:reservation_id]) # TODO: refactor this. its too dangerous. # TechQuestion
      @owner_player = @reservation.owner_player
    end

    def find_join_request
      # @join_request = JoinRequest.find_by(params.permit(:reservation_id, :player_id).slice(:reservation_id, :player_id)) # TechQuestion? - Cum e mai elegant aici
      @join_request = JoinRequest.find_by(reservation_id: params[:reservation_id], player_id: params[:player_id])
    end
end
