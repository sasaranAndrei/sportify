class AddStatusToJoinRequests < ActiveRecord::Migration[6.1]
  def change
    # nil => pending, true / false (approved)
    # TechQuestion20? - Era mai ok sa fac o clasa de JoinRequestStatus ca sa fie codu mai flexibil
    add_column :join_requests, :approved, :boolean, default: nil
  end
end
