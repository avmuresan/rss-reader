FactoryBot.define do
  factory :feed do
    title { Faker::Book.title }
    url { Faker::Internet.url }
  end
end
