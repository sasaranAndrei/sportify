require 'observer'

class ReservationPlayer < ApplicationRecord
  include Observable

  belongs_to :reservation
  belongs_to :player

  validate :owner_absence_from_guests_list

  JOIN_REQUEST = 'Join Request'
  INVITATION = 'Invitation'

  # def self.joining_options
    # [JOIN_REQUEST, INVITATION]
  # end

  def cancel
    create_reservation_player_observers
    penalize_player
    
    changed
    notify_observers(Time.now)

    self.destroy!
    self.destroy_join_request # TODO: fix this architecture bug
  end

  private

    def owner_absence_from_guests_list
      if player == reservation.owner_player # TechQuestion: cum e mai ok? player_id == reservation.owner_player_id
        errors.add(:reservation_owner, "must join. He can't be present in the Guests list too") 
      end
    end

    def penalize_player
      player.penalize(self.reservation)
    end
    
    def create_reservation_player_observers
      ReservationObservers::OwnerReservationPlayerObserver.new(self, reservation.owner_player)

      # TODO: decide if we should notify GuestPlayer since we have flashes for that
      # ReservationObservers::GuestReservationPlayerObserver.new(self, player)
    end

    def destroy_join_request
      JoinRequest.destroy_by(player_id: player.id, reservation_id: reservation.id)
    end
end
