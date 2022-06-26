FactoryBot.define do
  factory :reservation do
    booking_date { Faker::Name.name }
    booking_hour { Faker::Name.name }

    # TODO: cum fac sa mock-uiesc un user
    # ideea e ca am nevoie de ceva care sa poata raspunda la
    # .avatar, .email, .remove_tokens!, 
    # check cu cartea in paralel
    # si cu proiectele de la lucru in paralel

    trait :with_invitation_token do
      invitation_token { SecureRandom.hex(10) } # TechQuestion? - E ok sa fac asta? Cand se ruleaza testu si se adauga chestii in test_db se ruleaza codu asta? ca trebe sa fie unic ala check app/models/reservation.rb
    end

    trait :without_invitation_token do
      invitation_token { nil }
    end
  end
end
