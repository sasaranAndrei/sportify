class JoinRequest < ApplicationRecord
  belongs_to :player
  belongs_to :reservation

  def status
    return 'Waiting for Owner Player response' if approved.nil?
    return 'Declined' if approved.false?

    'Approved'
  end
end
