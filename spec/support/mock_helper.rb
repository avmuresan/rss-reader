module MockHelper
  WEB_MOCKS = {
    bbc_news: 'http://feeds.bbci.co.uk/news/rss.xml',
    css_tricks: 'http://feeds.feedburner.com/CssTricks',
    tech_news: 'http://feeds.reuters.com/reuters/technologyNews'
  }.freeze

  MOCKS_PATH = %w(spec fixtures rss_feeds).freeze
end

RSpec.configure do |config|
  config.before(:each) do
    # stub_request(:any, /.*/).to_return(status: 200)

    MockHelper::WEB_MOCKS.each do |name, url|
      file = Rails.root.join(*MockHelper::MOCKS_PATH, "#{name}.xml")
      stub_request(:get, /#{url}/).to_return(status: 200, body: file.read)
    end
  end
end
