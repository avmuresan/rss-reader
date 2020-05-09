module Api
  class ArticlesController < ApiController
    before_action :set_articles

    def index
    end

    protected

    def set_articles
      @articles = Feed.find_each.map(&:articles).flatten.sort_by(&:date)
    end
  end
end
