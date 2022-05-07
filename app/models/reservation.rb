class Reservation < ApplicationRecord
  belongs_to :owner_player, class_name: 'Player'
  belongs_to :field

  has_many :reservation_players

  scope :upcoming, -> { where('booking_date >= ?', Date.today) }
  scope :past, -> { where('booking_date < ?', Date.today) }

  def date
    "#{booking_date.strftime('%d/%m/%Y')} #{booking_hour}:00"
  end

  def place
    field.place
  end
end
