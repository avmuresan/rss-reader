require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#initialization' do
    let(:valid_rss_article) do
      Struct.new(:title, :link, :pubDate, :unused)
            .new('title', 'link', '11-11-2011', 'unused')
    end

    it 'should create the article' do
      article = Article.new(valid_rss_article)
      expect(article.title).to eq('title')
      expect(article.link).to eq('link')
      expect(article.date).to eq('11-11-2011')

      expect(article).to_not respond_to(:pubDate)
      expect(article).to_not respond_to(:unused)
    end

    let(:invalid_rss_article) do
      Struct.new(:title, :pubDate, :unused)
            .new('title', '11-11-2011', 'unused')
    end

    it 'should raise an error when rss article is invalid' do
      expect { Article.new(invalid_rss_article) }.to raise_error(ArgumentError)
    end
  end
end
