FactoryBot.define do
    factory :movie do
      title { Faker::Name.name }
      release_year { Faker::Number.between(1900, 2018) }
    end
  end