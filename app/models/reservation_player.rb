class ReservationPlayer < ApplicationRecord
  belongs_to :reservation
  belongs_to :player
end
