module ReservationsHelper
  def mocked_hours
    (0..23).map { |hour| Time.new(1, 1, 1, hour, 0).strftime('%H:%M') }
  end
end
