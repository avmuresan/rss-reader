FactoryBot.define do
  factory :feed do
    sequence(:title) { Faker::Book.title }
    sequence(:url) { Faker::Internet.url }
  end
end
