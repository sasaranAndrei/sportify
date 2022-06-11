class Field < ApplicationRecord
  belongs_to :arena
  belongs_to :sport

  has_many :reservations

  validates :label, presence: true
  validates :min_players, presence: true, 
                          numericality: { greater_than: 0 }
  validates :max_players, presence: true, 
                          numericality: { greater_than: :min_players }

  def place
    "#{label}, #{arena.title}"
  end

  def occupied_on?(date, hour)
    occupied_datetimes = timetable(date).pluck(:booking_date, :booking_hour)
    
    occupied_datetimes.include?([date, hour])
  end

  private
    # TODO: REFACTOR
    # creca mai bine fac call cu initial_date || Date.today
    def timetable(initial_date)
      initial_date.present? ? reservations.where('booking_date >= ? AND booking_date < ?', initial_date, initial_date + 1.week)
                            : reservations.upcoming
    end
end
