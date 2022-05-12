class JoinRequest < ApplicationRecord
  belongs_to :player
  belongs_to :reservation
end
