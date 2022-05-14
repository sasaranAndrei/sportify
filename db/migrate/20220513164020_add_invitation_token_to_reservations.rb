class AddInvitationTokenToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :invitation_token, :string
  end
end
