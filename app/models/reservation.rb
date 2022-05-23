class Reservation < ApplicationRecord
  belongs_to :owner_player, class_name: 'Player'
  belongs_to :field

  has_many :reservation_players, dependent: :destroy
  has_many :guest_players, class_name: 'Player', through: :reservation_players, source: :player
  has_many :join_requests
  has_many :join_request_players, class_name: 'Player', through: :join_requests, source: :player do
    def awaiting
      where('join_requests.approved is NULL')
    end
    
    def confirmed
      where('join_requests.approved = ?', true)
    end
    
    def declined
      where('join_requests.approved = ?', false)
    end
  end

  scope :upcoming, -> { where('booking_date >= ?', Date.today) }
  scope :past, -> { where('booking_date < ?', Date.today) }
  scope :ordered, ->(direction) { order(booking_date: direction, booking_hour: direction) }

  def all_players
    # TODO: TechQuestion? - Come up with other idea
    owner_player = Player.where(id: owner_player_id) # yes, I know it's only an object
    guest_players.union(owner_player) # but I do it in order to call union here
  end

  # TODO: create a date private method for @date ||= Date.new(booking_date, booking_hour)
  # TODO: use a DP or some OOP tricky stuff
  # and renamed this display_data { date.strftime(display_format) }
  def date
    "#{booking_date.strftime('%d/%m/%Y')} #{booking_hour}:00"
  end
  
  # and renamed this chart_data { date.strftime(chart_format) }
  def chart_date
    "#{booking_date.strftime('%m/%d/%Y')} #{booking_hour}:00"
  end

  def place
    field.place
  end

  # TODO: TechQuestion? - Choosing Dependency Direction?
  # X change_more_than Y => x.dependency_method(y) ???
  # Player change_more_than Reservation => player.participate?(reservation)
  # Reservation change_more_than Player => reservation.participate?(player)
  # for now (05.22): Reservation will change more than Player
  def participate?(player)
    player == owner_player || guest_players.include?(player)
  end

  # TODO: same as above
  def awaiting_response?(player)
    join_request_players.awaiting.include?(player)
  end

  def has_passed?
    datetime = booking_date.to_time.change(hour: booking_hour)
  
    datetime < Time.now
  end

  def slots_status
    "#{all_players.count} / #{field.max_players} players"
  end

  def free_slots
    field.max_players - all_players.count
  end

  def invitation_link
    "#{Rails.application.routes.url_helpers.reservation_url(self)}?invitation_token=#{invitation_token}"
  end

  def generate_invitation_token!
    self.invitation_token = generate_token!
    self.save!
  end

  def valid_invitation_token?(token)
    # TODO: remove self. if you can
    self.invitation_token == token
  end

  private
    
    def generate_token!
      loop do
        token = SecureRandom.hex(10)
        break token unless Reservation.where(invitation_token: token).exists?
      end
    end
end
