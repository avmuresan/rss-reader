require 'rails_helper'

RSpec.describe Feed, type: :model do
  subject { FactoryBot.create(:feed) }

  describe '#validations' do
    let(:err) { 'Title needs to be between 3 and 50 characters.' }
    let(:er) { 'Feed already exists.' }

    it { is_expected.to be_valid }
    it { should validate_length_of(:title).is_at_least(3).with_message(err) }
    it { should validate_length_of(:title).is_at_most(50).with_message(err) }
    it { should validate_uniqueness_of(:url).case_insensitive.with_message(er) }
    it { should allow_value('http://www.google.ro').for(:url) }
    it { should_not allow_value('foo').for(:url) }

    it 'strips the url before saving' do
      url = '   http://aBc.cOm   '
      subject = FactoryBot.build(:feed, url: url)
      subject.save
      expect(subject.reload.url).to eq(url.strip)
    end
  end

  describe '#articles' do
    it 'should respond the list of articles' do
      raw_rss_response = '<xml></xml>'
      subject.expects(:rss_articles).returns(raw_rss_response)
      rss_articles = FactoryBot.build_list(:rss_article, 3)
      parsed_articles = OpenStruct.new(items: rss_articles)
      RSS::Parser.expects(:parse).with(raw_rss_response)
                 .returns(parsed_articles)

      expect(subject.articles.count).to eq(rss_articles.count)
      subject.articles.each_with_index do |article, index|
        expect(article.date).to eq(rss_articles[index].pubDate)
        expect(article.link).to eq(rss_articles[index].link)
        expect(article.title).to eq(rss_articles[index].title)
      end
    end

    it 'should respond with an empty array when there is an error raised' do
      subject.expects(:rss_articles).raises(StandardError)
      expect(subject.articles).to eq([])
    end
  end

  describe '#rss_articles' do
    it 'should retrieve the rss articles using a single API request' do
      response_body = 'dummy response'
      response = OpenStruct.new(read: response_body)
      uri = URI.parse(subject.url)
      uri.expects(:open).returns(response)
      subject.expects(:parsed_url).returns(uri)

      expect(subject.rss_articles).to eq(response_body)

      stub.expects(:open).never
      expect(subject.rss_articles).to eq(response_body)
    end

    it 'should raise exception when something is wrong' do
      uri = subject.parsed_url
      uri.expects(:open).raises(StandardError)
      subject.expects(:parsed_url).returns(uri)
      expect { subject.rss_articles }.to raise_error(StandardError)
    end
  end

  describe '#parsed_url' do
    it 'should respond with the parsed url' do
      expect(subject.parsed_url).to eq(URI.parse(subject.url))
    end
  end

  describe '#cache_key' do
    it 'should respond with the feed cache key' do
      timestamp = Time.zone.now.beginning_of_hour.strftime('%Y-%m-%d|%H')
      cache_key = "articles/#{subject.id}/#{timestamp}"
      expect(subject.cache_key).to eq(cache_key)
    end
  end
end
