# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :user, dependent: :destroy

  has_many :own_reservations, class_name: 'Reservation'
  has_many :reservation_players
  has_many :guest_reservations, class_name: 'Reservation', through: :reservation_players, source: :reservation
end
