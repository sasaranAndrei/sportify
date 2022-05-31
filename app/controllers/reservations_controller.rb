class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy join_request generate_invitation_link accept_invitation ]

  def index
    # @reservations = Reservation.all
    @recent_reservations = Reservation.past.ordered(:asc).last(5)
    @upcoming_reservations = Reservation.upcoming.ordered(:asc)
    # @reservations = Reservation.all # la un moment dat AvailableReservationsService.call // cv din ReservationManager
  end

  def show
    @show_invitation_link = false

    if params[:invitation_token]
      current_player = current_user.player # TODO: check why current_player is visible only in views, not in controllers too
      valid_invitation_token = @reservation.valid_invitation_token?(params[:invitation_token])
      @show_invitation_link = !@reservation.participate?(current_player)

      redirect_back(fallback_location: reservations_player_path(current_player), notice: 'You cannot accept Invitation of your own Reservation') if @reservation.owner_player == current_player
      redirect_to root_path, notice: 'Invalid Token! Try again!' unless valid_invitation_token   
      redirect_to reservation_path(@reservation), notice: 'You already joined this Reservation!' if @reservation.participate?(current_player)
    end

    @owner_player = @reservation.owner_player
  end

  def new
    return redirect_to arenas_path, notice: 'Please select an Arena before create a Reservation' if params[:arena_id].blank? # TODO: move this to method

    @arena = Arena.find(params[:arena_id])
    # @scheduler = ArenaSchedulerService.call(arena: @arena, start_date: Date.today)
    @reservation = Reservation.new
  end

  def edit
  end

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

  def destroy
    byebug # don;t do this only if you know what you are doing
    # TODO: also delete ReservationPlayer objects
    # TODO: find a way to notify players (trough SMS - improvement dupa ce i gata licenta)
    # @reservation.destroy
    @reservation.cancel

    redirect_back(fallback_location: reservations_player_path(current_user.player), notice: 'You will regret this!')
  end

  # nuj daca o sa mai am nevoie de asta?
  def join_requests
    # can use @reservation
  end

  def generate_invitation_link
    @reservation.generate_invitation_token!
    
    redirect_back(fallback_location: reservation_path(@reservation), notice: 'Invitation Link Successfully generated!')
  end

  def accept_invitation
    current_player = current_user.player

    ReservationPlayer.find_or_create_by!(
      reservation_id: @reservation.id,
      player_id: current_player.id,
      joined_by: ReservationPlayer::INVITATION
    )
  
    redirect_to reservation_path(@reservation), notice: 'Successfully Join by Invitation!'
  end

  private
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
    
    def reservation_params
      params.require(:reservation).permit(:booking_date, :booking_hour, :owner_player_id, :arena_id, :field_id)
    end
  end
