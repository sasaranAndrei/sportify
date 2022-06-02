module ReservationObservers
  class ReservationPlayerObserver
    # reservation_subject => ducktype: poate fii reservation / reservation_player
    def initialize(reservation_subject, player)
      @player = player
      reservation_subject.add_observer(self)
    end
  end

  # TODO: find a way to notify players (trough SMS - improvement dupa ce i gata licenta)
  # cand owner player-ul da cancel la reservation
  # class OwnerPlayerObserver < ReservationPlayerObserver
  #   def update(time, status = 'TODO')
  #     puts "I am Owner Player observer"
  #     puts "Name: #{@player.nickname}"


  #     # It works!
  #     # TODO: Delete ReservationPlayer # nu creca trebe ca has_many :destroy
  #   end
  # end
  
  # cand owner player-ul da cancel la reservation => notifica reservation_players
  class GuestPlayerObserver < ReservationPlayerObserver
    def update(time, status = 'TODO')
      puts "I am Guest Player observer"
      puts "Name: #{@player.nickname}"
      # It works!
      # TODO: Delete ReservationPlayer
    end
  end

  # cand un guest player da cancel la reservation => notifica reservation_players
  class OwnerReservationPlayerObserver < ReservationPlayerObserver
    def update(time, status = 'TODO')
      puts "I am Owner ReservationPlayer observer"
      puts "Name: #{@player.nickname}"
    end
  end

  # class GuestReservationPlayerObserver
  #   def update(time, status = 'TODO')
  #     puts "I am Guest ReservationPlayer observer"
  #     puts "Name: #{@player.nickname}"
  #   end
  # end
end
