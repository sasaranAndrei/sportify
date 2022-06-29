# frozen_string_literal: true

class Player < ApplicationRecord
  # TODO: Move in a separate class
  FINE_AMOUNT = Hash.new(1).merge(
    0 => 20,
    1 => 10,
    2 => 5
  ).freeze

  belongs_to :user, dependent: :destroy

  has_many :own_reservations, class_name: 'Reservation', foreign_key: 'owner_player_id'
  has_many :reservation_players
  has_many :guest_reservations, class_name: 'Reservation', through: :reservation_players, source: :reservation
  has_many :join_requests
  has_many :join_request_reservations, class_name: 'Reservation', through: :join_requests, source: :reservation
  has_many :own_reviews, class_name: 'PlayerReview', foreign_key: 'player_id'
  has_many :guest_reviews, class_name: 'PlayerReview', foreign_key: 'reviewer_id'
  # has_many :items, class_name: 'Sellable' # TechQuestion3 - Se poate face ceva de genu? 
  # TODO: check single table inheritance
  has_many :tshirts
  has_many :balls

  before_validation :normalize_name

  validates :name, presence: true, length: { maximum: 30 }
  validates :birth_date, presence: true
  validate :birth_date_in_the_past
  validates :phone_number, presence: true, 
                           format: { with: Regex::ROMANIAN_PHONE_NUMBER },
                           uniqueness: true

  def all_reservations
    own_reservations.union(guest_reservations)
  end

  def upcoming_reservations
    all_reservations.upcoming.ordered(:asc)
  end

  def past_reservations
    all_reservations.past.ordered(:asc)
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

    "#{reviews_rating.round(2)}/#{PlayerReview::RATING_MAX}"
  end

  def avatar
    user.avatar
  end

  def email
    user.email
  end

  def nickname
    read_attribute(:nickname) || name
  end

  def penalize(reservation)
    fine_amount = FINE_AMOUNT[reservation.days_before_booking_date]
    info = reservation.info

    # TODO remove puts
    puts "#{nickname}, you will be penalized with #{fine_amount} SCoins for canceling your reservation #{info}"

    user.remove_tokens!(fine_amount)
  end

  private
    def normalize_name
      self.name = name.strip.downcase.titleize
    end

    def birth_date_in_the_past
      errors.add(:birth_date, 'The birth date must be in the past') unless birth_date.past?
    end

    def reviews_rating
      own_reviews.average(:rating)
    end
end
