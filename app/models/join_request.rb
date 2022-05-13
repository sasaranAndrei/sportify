class JoinRequest < ApplicationRecord
  belongs_to :player
  belongs_to :reservation

  validate :owner_player

  def owner_player
    errors.add(:player, 'The owner player cannot create a JoinRequest for one of his Reservations') if player == reservation.owner_player
  end

  def status
    return 'Pending' if pending?
    return 'Approved' if approved

    'Declined'
  end

  def pending?
    approved.nil?
  end
end
