module ReservationObservers
  class ReservationPlayerObserver
    def initialize(reservation, player)
      @player = player
      reservation.add_observer(self)
    end
  end

  class OwnerPlayerObserver < ReservationPlayerObserver
    def update(time, status = 'TODO')
      puts "I am Owner Player observer"
      puts "Name: #{@player.nickname}"
      # It works!
      # TODO: Delete ReservationPlayer
    end
  end
  
  class GuestPlayerObserver < ReservationPlayerObserver
    def update(time, status = 'TODO')
      puts "I am Guest Player observer"
      puts "Name: #{@player.nickname}"
      # It works!
      # TODO: Delete ReservationPlayer
    end
  end
end
