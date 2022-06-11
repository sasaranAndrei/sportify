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

  def display_timetable_for(field, initial_date)
    initial_date ||= Date.today
    final_date = initial_date + 6.days
    
    # (initial_date..final_date).collect do |date|
    #   Reservation::WORKING_HOURS.map do |hour|
    #     field.occupied_on?(date, hour) ? false : true
    #   end
    # end

    # refactor ca are n+1
    timetable = {}
    (initial_date..final_date).each do |date|
      timetable[date] = {}

      Reservation::WORKING_HOURS.each do |hour|
        timetable[date][hour] = field.occupied_on?(date, hour) 
      end
    end

    timetable
  end
end
