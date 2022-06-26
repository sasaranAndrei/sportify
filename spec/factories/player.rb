FactoryBot.define do
  factory :player do
    name { Faker::Name.name }
    birth_date { Faker::Date.birthday }
    phone_number { ['0745123123', '0754987987', '0755765765'].sample } # TODO: refactor this
    

    trait :with_nickname do
      nickname { Faker::Name.first_name }
    end

    trait :without_nickname do
      nickname { nil }
    end
  end
end
