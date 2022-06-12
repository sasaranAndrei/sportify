class ReservationsController < ApplicationController
  include ReservationsHelper

  before_action :set_reservation, only: %i[ show edit update destroy join_request generate_invitation_link accept_invitation ]
  skip_before_action :authenticate_user!, only: :index

  def index
    # @reservations = Reservation.all
    @recent_reservations = Reservation.past.ordered(:asc).last(5)
    @upcoming_reservations = Reservation.upcoming.ordered(:asc)
    # @reservations = Reservation.all # la un moment dat AvailableReservationsService.call // cv din ReservationManager
  end

  def show
    current_player = current_user.player # TODO: check why current_player is visible only in views, not in controllers too
    @show_invitation_link = false

    if params[:invitation_token]
      valid_invitation_token = @reservation.valid_invitation_token?(params[:invitation_token])
      @show_invitation_link = !@reservation.participate?(current_player)

      redirect_back fallback_location: reservations_player_path(current_player), notice: 'You cannot accept Invitation of your own Reservation' if @reservation.owner_player == current_player
      redirect_to root_path, notice: 'Invalid Token! Try again!' unless valid_invitation_token   
      redirect_to reservation_path(@reservation), notice: 'You already joined this Reservation!' if @reservation.participate?(current_player)
    else
      if !@reservation.participate?(current_player)
        return redirect_back fallback_location: reservations_path, notice: "Sorry, this Reservation has passed and you didn't participate" if @reservation.has_passed?

        redirect_to new_join_request_path(reservation_id: @reservation.id, player_id: current_player.id)
      end
    end

    @owner_player = @reservation.owner_player
    @reservation_player = ReservationPlayer.find_by(player: current_player, reservation: @reservation)
    @reservation_join_requests = @reservation.join_requests

    unless flash.any?
      flash.now[:notice] = 'This Reservation has passed' if @reservation.has_passed?
    end
  end

  def new
    return redirect_to arenas_path, notice: 'Please select an Arena before create a Reservation' if params[:arena_id].blank? # TODO: move this to method

    @arena = Arena.find(params[:arena_id])
    # @scheduler = ArenaSchedulerService.call(arena: @arena, start_date: Date.today)
    @selected_field = params[:field_id].present? ? Field.find(params[:field_id]) : @arena.fields.first
    @field_timetable = display_timetable_for(@selected_field, params[:initial_date])
    
    @reservation = Reservation.new
  end

  def timetable
    selected_field = params[:field_id].present? ? Field.find(params[:field_id]) : @arena.fields.first
    timetable = display_timetable_for(selected_field, params[:initial_date])
  
    render json: { timetable: timetable }
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

    # TODO: move into function cumva nuj
    @selected_field = @reservation.field
    @field_timetable = display_timetable_for(@selected_field, params[:initial_date])
    @arena = @selected_field.arena

    if @reservation.save
      redirect_to reservation_url(@reservation), notice: 'Reservation was successfully created.'
    else
      flash[:error] = @reservation.errors.full_messages.join('. ')
      # TODO: REFACTOOOR
      redirect_to new_reservation_path(arena_id: @arena.id)
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
    @reservation.cancel

    redirect_to root_path, notice: 'You have been penalized for this action!'
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
