# frozen_string_literal: true

class Player < ApplicationRecord
  # TODO: Move in a separate class
  FINE_AMOUNT = Hash.new(0).merge(
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
    # TechQuestion5 - De ce nu merge chestia asta? Ar trebui sa mearga, nu?
    # own_reservations.or(guest_reservations) # don't work
    # TODO: FIX THIS

    # varianta asta de mai jos foloseste union gem:
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

    "#{reviews_rating.round(2)}/#{PlayerReview::RATING_MAX}"
  end

  # RubyBookOOP #2 - Law of Demeter
  def avatar
    user.avatar
  end

  def email
    user.email
  end

  # RubyBookOOP #1 - wrap private dependency
  # in caller:
  # player.nickname INSTEAD_OF player.nickname || player.name
  def nickname
    read_attribute(:nickname) || name
  end

  def penalize(reservation)
    fine_amount = FINE_AMOUNT[reservation.days_before_booking_date]
    info = reservation.info

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
    
    def fine_amount(days_before_booking_date)
      # ideea cu constanta
      # FINE_AMOUNT.find { |days, fine| break fine if days.cover? days_before_booking_date }
    
      # raise Exception('WTF FINE_AMOUNT') if days_before_booking_date.negative?
      # return 20 if days_before_booking_date.zero?
      # return 10 if days_before_booking_date == 1
      # return 5 if days_before_booking_date == 2
      
      # 0
    end
end
