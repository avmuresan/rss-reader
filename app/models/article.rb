class Article
  attr_accessor :title, :date, :link

  def initialize(rss_article)
    if rss_article.respond_to?(:title) && rss_article.respond_to?(:link) &&
       rss_article.respond_to?(:pubDate)

      self.title = rss_article.title
      self.date = rss_article.pubDate
      self.link = rss_article.link
    else
      raise ArgumentError, 'invalid rss article'
    end
  end
end
