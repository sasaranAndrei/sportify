class JoinRequest < ApplicationRecord
  belongs_to :player
  belongs_to :reservation

  validate :owner_player
  validate :reservation_free_slots

  def status
    return 'Pending' if pending?
    return 'Approved' if approved

    'Declined'
  end

  private
    def owner_player
      errors.add(:player, 'The owner player cannot create a JoinRequest for one of his Reservations') if player == reservation.owner_player
    end

    def reservation_free_slots
      errors.add(:reservation, 'There are no Free Slots on this Reservatino. Please choose another one') if reservation.no_free_slots?
    end

    def pending?
      approved.nil?
    end
end
