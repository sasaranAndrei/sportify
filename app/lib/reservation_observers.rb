module ReservationObservers
  class ReservationPlayerObserver
    # RubyOOP Book
    # reservation_subject => ducktype: poate fii reservation / reservation_player
    def initialize(reservation_subject, player)
      @player = player
      @reservation_subject = reservation_subject

      reservation_subject.add_observer(self)
    end

    def notify_cancel
      raise NotImplementedError, 'Define <<notify_cancel>> in the concrete Reservation Observers!' 
    end
  end

  # cand owner player-ul da cancel la reservation => notifica reservation_players
  class GuestPlayerObserver < ReservationPlayerObserver
    def update(time, status = 'TODO')
      puts "I am Guest Player observer"
      puts "Name: #{@player.nickname}"

      notify_cancel
      # It works!
      # TODO: Delete ReservationPlayer
    end

    def notify_cancel
      reservation = @reservation_subject # to be clear that we expect a reservation here

      ReservationMailer.notify_reservation_cancel(@player, reservation).deliver!
    end
  end

  # cand un guest player da cancel la reservation => notifica reservation_players
  class OwnerReservationPlayerObserver < ReservationPlayerObserver
    def update(time, status = 'TODO')
      puts "I am Owner ReservationPlayer observer"
      puts "Name: #{@player.nickname}"
      notify_cancel
      # It works!
      # TODO: Delete ReservationPlayer
    end

    def notify_cancel
      puts "TODO"
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
  
  # class GuestReservationPlayerObserver
  #   def update(time, status = 'TODO')
  #     puts "I am Guest ReservationPlayer observer"
  #     puts "Name: #{@player.nickname}"
  #   end
  # end
end
