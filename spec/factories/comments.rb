FactoryBot.define do
  factory :comment do
    text { "Test_comments" }
    association :user
    association :request
  end
end
