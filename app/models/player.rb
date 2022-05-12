# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :user, dependent: :destroy

  has_many :own_reservations, class_name: 'Reservation', foreign_key: 'owner_player_id'
  has_many :reservation_players
  has_many :guest_reservations, class_name: 'Reservation', through: :reservation_players, source: :reservation
  has_many :join_requests
  has_many :join_request_reservations, class_name: 'Reservation', through: :join_requests, source: :reservation

  def all_reservations
    # TechQuestion
    # own_reservations.or(guest_reservations) # don't work
    # TODO: FIX THIS

    own_reservations.union(guest_reservations)
    # [own_reservations, guest_reservations].inject(:union)

    # asta chiar nu stiu ce are
    # Reservation.joins(:reservation_players).where('reservation_players.player_id = :id OR reservations.owner_player_id = :id', id: id)
    
    # nici asta
    # Reservation.joins(:reservation_players).where('reservation_players.player_id = ?', id)
    #            .or(Reservation.where(owner_player_id: id))
    
    # la fel ca alea de mai sus
    # Reservation.where(reservation_players: { player_id: id }).or(Reservation.where(owner_player_id: id))
  end
end
