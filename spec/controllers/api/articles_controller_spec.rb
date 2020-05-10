require 'rails_helper'

describe Api::ArticlesController, type: :request do
  describe '#index' do
    before do
      feeds = FactoryBot.create_list(:feed, 3)
      @all_articles = []
      feeds.each do |feed|
        rss_articles = FactoryBot.build_list(:rss_article, 3)
        articles = rss_articles.map do |rss_article|
          Article.new(rss_article, feed)
        end
        @all_articles.push(*articles)
        feed.expects(:articles).returns(articles)
      end
      Feed.expects(:find_each).returns(feeds)
    end

    it 'responds with all articles json' do
      get api_articles_url
      expect(response.status).to eq 200
      expect(json['articles'].length).to eq(@all_articles.count)
    end

    it 'responds with all articles sorted by date json' do
      get api_articles_url
      titles = json['articles'].map { |article| article['title'] }
      expected_titles = @all_articles.sort_by(&:date).map(&:title).reverse
      expect(titles).to eq(expected_titles)
    end
  end
end
