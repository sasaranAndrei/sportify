module ReservationsHelper
  def mocked_hours
    (0..23).map { |hour| Time.new(1, 1, 1, hour, 0).strftime('%H:%M') }
  end

  def highlight_reservation_class(reservation, player)
    return 'error-notice-background' if reservation.has_passed?
    return 'participate-reservation-highlight' if reservation.participate?(player)
    # return 'guest-reservation-highlight' if reservation.guest_players.include?(player)
  end
end
