# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :user, dependent: :destroy

  has_many :own_reservations, class_name: 'Reservation', foreign_key: 'owner_player_id'
  has_many :reservation_players
  has_many :guest_reservations, class_name: 'Reservation', through: :reservation_players, source: :reservation
  has_many :join_requests
  has_many :join_request_reservations, class_name: 'Reservation', through: :join_requests, source: :reservation
  has_many :own_reviews, class_name: 'PlayerReview', foreign_key: 'player_id'
  has_many :guest_reviews, class_name: 'PlayerReview', foreign_key: 'reviewer_id'

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

  def guest_join_requests
    # own_reservations.map(&:join_requests) # asta nu creca e ok 
    # TODO: use ARUnion for this
    JoinRequest.where(reservation_id: own_reservations.pluck(:id))
  end

  def age
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

  def rating
    return 'N/A' if reviews_rating.nil?

    "#{reviews_rating}/#{PlayerReview::RATING_MAX}"
  end

  def avatar
    user.avatar
  end

  private

    def reviews_rating
      own_reviews.average(:rating)
    end
end
