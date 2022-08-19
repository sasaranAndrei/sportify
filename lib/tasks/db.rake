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

  namespace :export do
    task location_data: :environment do
      arenas_filepath = File.join(Rails.root, 'db', 'json_data', 'arenas.json')
      fields_filepath = File.join(Rails.root, 'db', 'json_data', 'fields.json')

      arenas = Arena.all.as_json
      fields = Field.all.as_json

      puts arenas_filepath
      File.open(arenas_filepath, 'w') do |f|
        f.write(JSON.pretty_generate(arenas))
      end
      File.open(fields_filepath, 'w') do |f|
        f.write(JSON.pretty_generate(fields))
      end
    end
  end

  namespace :import do
    task location_data: :environment do
      arenas_filepath = File.join(Rails.root, 'db', 'json_data', 'arenas.json')
      fields_filepath = File.join(Rails.root, 'db', 'json_data', 'fields.json')

      arenas = JSON.parse(File.read(arenas_filepath))
      fields = JSON.parse(File.read(fields_filepath))

      arenas.each { |arena| Arena.create!(arena) }
      fields.each { |field| Field.create!(field) }
    end
  end
end
