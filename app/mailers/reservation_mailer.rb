class ReservationMailer < ApplicationMailer
  def notify_reservation_cancel(player, reservation)
    @player = player
    @owner_player = reservation.owner_player
    @reservation_info = reservation.info

    mail to: player.email, subject: "Player #{@owner_player.nickname} canceled reservation #{@reservation_info}"
  end

  def notify_reservation_player_cancel(player, reservation_player)

  end


  # TODO: reminders...
end
