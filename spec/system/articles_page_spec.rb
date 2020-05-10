require 'rails_helper'

RSpec.describe 'Articles page', type: :system do
  let(:empty_label) { 'There are no articles to display here.' }
  describe 'with no articles' do
    it 'shows the right content' do
      visit '/'
      expect(page).to have_content('Latest articles')
    end

    it 'shows the empty articles message' do
      visit '/'
      expect(page).to have_content(empty_label)
      click_on 'Configure feeds'
      expect(page).to have_current_path('/feeds')
    end

  end

  describe 'with articles' do
    before(:each) do
      MockHelper::WEB_MOCKS.each do |title, url|
        FactoryBot.create(:feed, title: title, url: url)
      end
    end

    let(:first_article_title) do
      'Dennis Bergkamp scores wonder goal for Netherlands against Argentina'
    end

    let(:last_article_title) do
      "The FBI said I was my parents' stolen baby - but I found the truth"
    end

    it 'shows the articles from existing feeds' do
      visit '/'
      expect(page).not_to have_content(empty_label)
      expect(page).to have_selector('.card', count: 66)
      articles = page.all('.card')
      expect(articles.first.find('.card-title').text).to eq(first_article_title)
      expect(articles.last.find('.card-title').text).to eq(last_article_title)
    end

    it 'follows the article link when clicking the read button' do
      visit '/'
      href = 'https://www.bbc.co.uk/sport/av/football/52559830'
      expect(page).to have_selector("a[href='#{href}']", text: 'Read article')
    end
  end
end
