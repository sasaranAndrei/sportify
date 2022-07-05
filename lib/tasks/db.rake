# TechQuestion - is good to extend rake db:seed command like this?

namespace :db do
  namespace :seed do
    task create_reservations: :environment do
      player_ids = Player.pluck(:id)
      field_ids = Field.pluck(:id)

      dates = (6..13).to_a.map { |day| Date.new(2022, 7, day) }
      hours = (10..21).to_a

      100.times do
        player_id = player_ids.sample
        field_id = field_ids.sample
        booking_date = dates.sample
        booking_hour = hours.sample

        reservation = Reservation.new(
                        owner_player_id: player_id,
                        field_id: field_id,
                        booking_date: booking_date,
                        booking_hour: booking_hour
                      )

        reservation.save
      end

    end    
  end
end
