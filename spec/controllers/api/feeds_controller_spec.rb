require 'rails_helper'

describe Api::FeedsController, type: :request do
  describe '#index' do
    before do
      FactoryBot.create_list(:feed, 7)
    end

    it 'responds with all feeds json' do
      get api_feeds_url
      expect(response.status).to eq 200
      expect(json['feeds'].length).to eq(7)
    end

    it 'responds with all feeds sorted by title json' do
      get api_feeds_url
      ids = json['feeds'].map { |feed| feed['id'] }
      expect(ids).to eq(Feed.order(:title).pluck(:id))
    end
  end

  describe '#create' do
    let(:create_params) { { feed: { title: 'feed', url: 'http://www.g.ro' } } }

    it 'responds with the newly created feed json' do
      expect { post api_feeds_url(create_params) }.to change(Feed, :count).by(1)
      expect(response.status).to eq 200
      expect(json['feed']['title']).to eq(create_params[:feed][:title])
      expect(json['feed']['url']).to eq(create_params[:feed][:url])
    end

    let(:bad_params) { { feed: { title: 'feed', url: 'invalid' } } }
    let(:expected_invalid_response) { { 'url' => ['is invalid'] } }

    it 'responds with the create errors json' do
      expect { post api_feeds_url(bad_params) }.to change(Feed, :count).by(0)
      expect(response.status).to eq 422
      expect(json).to eq(expected_invalid_response)
    end
  end

  let(:feed) { FactoryBot.create(:feed) }
  let(:feed_response) { feed.attributes.slice(*%w(id title url)) }

  describe '#show' do
    it 'responds with the feed json' do
      get api_feed_url(feed.id)
      expect(response.status).to eq 200
      expect(json['feed'].slice(*%w(id title url))).to eq(feed_response)
    end

    it 'responds with 404 when the feed is not found' do
      get api_feed_url(1337)
      expect(response.status).to eq 404
    end
  end

  describe '#update' do
    let(:update_params) { { feed: { title: 'new feed name' } } }

    it 'responds with the updated feed json' do
      put api_feed_url(feed.id, update_params)
      expect(response.status).to eq 200
      expect(json['feed']['name']).to eq(update_params[:feed][:name])
      expect(json['feed']['url']).to eq(feed.url)
    end

    let(:invalid_params) { { feed: { title: '' } } }
    let(:expected_invalid_response) do
      {
        'title' => ['is too short (minimum is 3 characters)']
      }
    end

    it 'responds with the update errors json' do
      put api_feed_url(feed.id, invalid_params)
      expect(response.status).to eq 422
      expect(json).to eq(expected_invalid_response)
    end

    it 'responds with 404 when the feed is not found' do
      put api_feed_url(1337, update_params)
      expect(response.status).to eq 404
    end
  end

  describe '#destroy' do
    it 'responds with the destroyed feed json' do
      feed
      expect { delete api_feed_url(feed.id) }.to change(Feed, :count).by(-1)
      expect(response.status).to eq 200
      expect(json['feed']['title']).to eq(feed.title)
    end

    it 'responds with 404 when the feed is not found' do
      delete api_feed_url(1337)
      expect(response.status).to eq 404
    end
  end
end
