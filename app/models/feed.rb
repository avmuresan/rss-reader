require 'rss'
require 'open-uri'

class Feed < ApplicationRecord
  validates :title, length: 3..50
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(['http', 'https'])

  def articles
    @articles ||= begin
      feed = RSS::Parser.parse(rss_articles)
      feed.items.map { |rss_article| Article.new(rss_article) }
    end
  rescue StandardError => e
    Rails.logger.debug(e.message)
    []
  end

  def rss_articles
    Rails.cache.fetch(cache_key) { parsed_url.open.read }
  end

  def parsed_url
    @parsed_url ||= URI.parse(url)
  end

  def cache_key
    timestamp = Time.zone.now.beginning_of_hour.strftime('%Y-%m-%d|%H')
    "articles/#{id}/#{timestamp}"
  end
end
