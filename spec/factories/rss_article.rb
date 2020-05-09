class RssArticle < Struct.new(:pubDate, :link, :title); end

FactoryBot.define do
  factory :rss_article do
    title { Faker::Book.title }
    pubDate { rand(1.day.ago..Time.zone.now) }
    link { Faker::Internet.url }
  end
end
