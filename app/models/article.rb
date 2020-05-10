class Article
  attr_accessor :title, :date, :link, :channel

  def initialize(rss_article, feed)
    if rss_article.respond_to?(:title) && rss_article.respond_to?(:link) &&
       rss_article.respond_to?(:pubDate)

      self.title = rss_article.title
      self.date = rss_article.pubDate
      self.link = rss_article.link
      self.channel = feed.title
    else
      raise ArgumentError, 'invalid rss article'
    end
  end
end
