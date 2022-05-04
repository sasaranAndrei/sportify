class Reservation < ApplicationRecord
  belongs_to :owner_player, class_name: 'Player'
  belongs_to :field

  has_many :reservation_players
  has_many :guest_players, class_name: 'Player', through: :reservation_players, source: :player
end
