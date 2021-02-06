FactoryBot.define do
  factory :request do
    title {Faker::Team.name}
    text {Faker::Lorem.sentence}
    category_id { 2 }
    association :user
  end
end
