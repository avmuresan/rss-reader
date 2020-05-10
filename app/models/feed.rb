require 'rss'
require 'open-uri'

class Feed < ApplicationRecord
  URL_PROTOCOLS = ['http', 'HTTP', 'https', 'HTTPS'].freeze
  validates :title,
            length: {
              in: 3..50,
              message: 'Title needs to be between 3 and 50 characters.'
            }
  validates :url,
            uniqueness: { case_sensitive: false,
                          message: 'Feed already exists.' },
            format: { with: URI::DEFAULT_PARSER.make_regexp(URL_PROTOCOLS),
                      message: 'Invalid URL.' }

  before_save :downcase_url

  def articles
    @articles ||= begin
      feed = RSS::Parser.parse(rss_articles)
      feed.items.map { |rss_article| Article.new(rss_article, self) }
    end
  rescue StandardError => e
    Rails.logger.debug(e.message)
    []
  end

  def rss_articles
    Rails.cache.fetch(cache_key, expires_in: 2.hours) { parsed_url.open.read }
  end

  def parsed_url
    @parsed_url ||= URI.parse(url)
  end

  def cache_key
    timestamp = Time.zone.now.beginning_of_hour.strftime('%Y-%m-%d|%H')
    "articles/#{id}/#{timestamp}"
  end

  protected

  def downcase_url
    self.url = url&.strip
  end
end
