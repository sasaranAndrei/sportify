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
    

    # TechQuestion13? - Avand in vedere ca defapt nu updatez obiectul ci il sterg,
    # nu se face notify_obsers din cauza ca nu i changed, si tre sa l apelez manual inainte
    # Cum pot evita chestia asta?
    notify_observers(Time.now)
    changed

    self.destroy!
    self.destroy_join_request # TODO: fix this architecture bug
    # TechQuestion21 Cum ar fii mai ok sa leg JoinRequest-u de ReservationPlayer? 
    # reservation_player has_one :join_request, optional: true, dependent: destroy ?
    
    # check to be the same behaviour
    # notify_observers(Time.now)
    # TODO
  end

  private

    def owner_absence_from_guests_list
      if player == reservation.owner_player # TechQuestion1: Cum e mai ok? player_id == reservation.owner_player_id
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
