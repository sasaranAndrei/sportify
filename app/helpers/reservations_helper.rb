module ReservationsHelper
  def mocked_hours
    (0..23).map { |hour| Time.new(1, 1, 1, hour, 0).strftime('%H:%M') }
  end

  def highlight_reservation_class(reservation, player)
    return 'error-notice-background' if reservation.has_passed?
    return 'participate-reservation-highlight' if reservation.participate?(player) # TechQuestion - Numele sugereaza mai degraba invers: player.participate?(reservation), dar callu trebuie facut pe obiectu de reservare. cum sa redenumesc functia?
    # return 'guest-reservation-highlight' if reservation.guest_players.include?(player)
  end
end
