class Reservation < ApplicationRecord
  belongs_to :owner_player, class_name: 'Player'
  belongs_to :field

  has_many :reservation_players
  has_many :guest_players, class_name: 'Player', through: :reservation_players, source: :player

  scope :upcoming, -> { where('booking_date >= ?', Date.today) }
  scope :past, -> { where('booking_date < ?', Date.today) }
  scope :ordered, ->(direction) { order(booking_date: direction, booking_hour: direction) }

  def date
    "#{booking_date.strftime('%d/%m/%Y')} #{booking_hour}:00"
  end

  def place
    field.place
  end

  def participate?(player)
    player == owner_player || guest_players.include?(player)
  end

  def has_passed?
    datetime = booking_date.to_time.change(hour: booking_hour)
  
    datetime < Time.now
  end
end
