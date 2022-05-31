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
  
  end

  private

    def owner_absence_from_guests_list
      if player == reservation.owner_player # TechQuestion: cum e mai ok? player_id == reservation.owner_player_id
        errors.add(:reservation_owner, "must join. He can't be present in the Guests list too") 
      end
    end
end
