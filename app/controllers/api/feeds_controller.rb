module Api
  class FeedsController < ApiController
    before_action :set_feeds, except: :create
    before_action :set_feed, except: [:index, :create]

    def index
    end

    def show
    end

    def create
      @feed = Feed.new(feed_params)
      regular_response(&:save)
    end

    def update
      regular_response { |feed| feed.update(feed_params) }
    end

    def destroy
      regular_response(&:destroy)
    end

    protected

    def set_feeds
      @feeds = Feed.order(:title)
    end

    def set_feed
      @feed = @feeds.find(params[:id])
    end

    def regular_response
      if yield(@feed)
        render :show, status: :ok
      else
        render json: @feed.errors, status: :unprocessable_entity
      end
    end

    def feed_params
      params.require(:feed).permit(:title, :url)
    end
  end
end
