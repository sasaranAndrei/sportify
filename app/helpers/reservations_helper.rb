module ReservationsHelper
  def mocked_hours
    # old version
    # Reservation::WORKING_HOURS.map { |hour| Time.new(1, 1, 1, hour, 0).strftime('%H:%M') }
    
    # new version
    Reservation::WORKING_HOURS.map do |hour|
      Reservation.new(booking_hour: hour)
                 .display_datetime(:mock)
    end
  end

  def highlight_reservation_class(reservation, player)
    return 'error-notice-background' if reservation.has_passed?
    return 'participate-reservation-highlight' if reservation.participate?(player)
  end
end
