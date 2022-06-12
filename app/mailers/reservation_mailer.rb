class ReservationMailer < ApplicationMailer
  def notify_reservation_cancel(guest_player, reservation, time)
    @guest_player = guest_player
    @owner_player = reservation.owner_player
    @reservation_info = reservation.info
    @time = time

    mail to: @guest_player.email, subject: "Player #{@owner_player.nickname} canceled reservation #{@reservation_info}"
  end

  def notify_reservation_player_cancel(owner_player, reservation_player, time)
    @guest_player = reservation_player.player
    @owner_player = owner_player
    @reservation_info = reservation_player.reservation.info
    @time = time

    mail to: @owner_player.email, subject: "Player #{@guest_player.nickname} left reservation #{@reservation_info}"
  end


  # TODO: reminders...
end
