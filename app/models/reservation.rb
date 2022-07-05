require 'observer'

class Reservation < ApplicationRecord
  include Observable

  WORKING_HOURS = (10..21).to_a.freeze
  DEFAULT_DATE_FORMAT = '%d/%m/%Y %H:%M'.freeze
  DATE_FORMATS = Hash.new(DEFAULT_DATE_FORMAT).merge(
    # reservation: '%d/%m/%Y %H:%M',
    chart: '%m/%d/%Y %H:%M',
    timetable: '%a %d/%m',
    # timetable: '',
    # change to time
    mock: '%H:%M' # TechQuestion9 - Aici ar fii mai bine sa redenumesc cheia 'time'?
    # Ma gandesc ca asa as putea sa l folosesc si in alte scopuri decat 'mock'.
    # Dar mai e si chestia ca daca vreau sa schimb cum se afisaza 'mock',
    # tre sa adaug un nou key, val.
  ).freeze

  belongs_to :owner_player, class_name: 'Player'
  belongs_to :field

  has_many :reservation_players, dependent: :destroy
  has_many :guest_players, class_name: 'Player', through: :reservation_players, source: :player
  has_many :join_requests, dependent: :destroy
  has_many :join_request_players, class_name: 'Player', through: :join_requests, source: :player do
    # TODO: how to test these associations
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

  # validates :booking_date, presencec: true, date: { after: Proc.new { Time.now } }
  validates :booking_date, presence: true
  validates :booking_hour, presence: true #, inclusion: WORKING_HOURS
  validate :reservation_date_working_hours
  validates_uniqueness_of :field, scope: %i[booking_date booking_hour], message: ' is already booked on this time. Please choose another time.'

  scope :upcoming, -> { where('booking_date >= ?', Date.today) }
  scope :past, -> { where('booking_date < ?', Date.today) }
  scope :ordered, ->(direction) { order(booking_date: direction, booking_hour: direction) }

  def all_players
    # tot cu sql mai elegant
    # TODO: TechQuestion10? - Come up with other idea. all_players = owner_player + guest_players (and I need to keep the all_players as an AR relation)
    owner_player = Player.where(id: owner_player_id) # yes, I know it's only an object
    guest_players.union(owner_player) # but I do it in order to call union here
  end

  # TODO: This feels like it doesn t belong to Reservation. This will be moved into a Decorator
  def display_datetime(format_option = nil)
    # RubyBook #4 - 'Kind of' Duck Types (not really because its not based on klass)
    datetime.strftime(DATE_FORMATS[format_option])
    
    # instead of:

    # case display_format
    # when :chart
    #    date.strftime('#chart_format')
    # when :reservation
    #   date.strftime('#reservation_format')
    # when :mock
    #   date.strftime('#mock_format')
    # end
  end

  def info
    "on #{display_datetime} at #{place}"
  end

  # RubyBookOOP #2 - Law of Demeter
  def place
    field.place
  end

  # TODO: TechQuestion11? - Choosing Dependency Direction?
  # X change_more_than Y => x.dependency_method(y) ???
  # Player change_more_than Reservation => player.participate?(reservation)
  # Reservation change_more_than Player => reservation.participate?(player)
  # for now (05.22): Reservation will change more than Player
  def participate?(player)
    player == owner_player || guest_players.include?(player)
  end

  # TODO: TechQuestion11? - Choosing Dependency Direction?
  def awaiting_response?(player)
    join_request_players.awaiting.include?(player)
  end

  def has_passed?
    datetime < Time.now
  end

  def days_before_booking_date
    (booking_date - Date.today).to_i
  end

  def slots_status
    "#{all_players.count} / #{field.max_players} players"
  end

  def free_slots
    field.max_players - all_players.count
  end

  # TechQuestion12 - It would be a bad practice to name
  # this method free_slots(?)
  # eu cred ca nu deoarece ar putea fii inconsistente gen: free_slots? == false // free_slots == 0 if code changes
  def no_free_slots?
    free_slots <= 0
  end

  def invitation
    # TODO: i18n
    return 'Invitation Link disabled due to lack of Free Slots' if no_free_slots?
  
    invitation_link
  end

  def generate_invitation_token!
    self.invitation_token = generate_token!
    self.save!
  end

  def valid_invitation_token?(token)
    # TODO: remove self. if you can
    self.invitation_token == token
  end

  def cancel
    # <client call>
    create_reservation_player_observers

    penalize_owner_player
    
    # TechQuestion13? - Avand in vedere ca defapt nu updatez obiectul ci il sterg,
    # nu se face notify_obsers din cauza ca nu i changed, si tre sa l apelez manual inainte
    # Cum pot evita chestia asta?
    changed
    notify_observers(Time.now)

    self.destroy!
  end

  private
    # TechQuestion14 ? - Is this good? Ma refer la Dependencies, OOP Design, ...
    def penalize_owner_player
      owner_player.penalize(self)
    end

    def reservation_date_working_hours
      # TODO: field.working_hours
      # momentan e ok asa, nu am facut cu validate inclusion
      # ca sa am interfata publica ok, 
      # si asta privata sa o schimb cand o sa trebuiasca
      booking_date > Date.yesterday && WORKING_HOURS.include?(booking_hour)
    end

    def datetime
      # TechQuestion15 - Chestia de mai jos o sa functioneze daca fac update la booking_date / boooking_hour
      # @datetime ||= Time.parse("#{booking_hour}:00", booking_date)
      Time.parse("#{booking_hour}:00", booking_date)
    end

    def create_reservation_player_observers
      # TODO: decide if we should notify OwnerPlayer since we have flashes for that
      # ReservationObservers::OwnerPlayerObserver.new(self, owner_player)

      guest_players.each do |guest_player|
        ReservationObservers::GuestPlayerObserver.new(self, guest_player)
      end
    end
    
    def generate_token!
      loop do
        token = SecureRandom.hex(10)
        break token unless Reservation.where(invitation_token: token).exists?
      end
    end
    
    def invitation_link
      "#{Rails.application.routes.url_helpers.reservation_url(self)}?invitation_token=#{invitation_token}"
    end
    
    # RubyBook #3 - Hide Data Structures #TODO
    # class Invitation; end
    # Invitation = OpenStruct.new()
end
