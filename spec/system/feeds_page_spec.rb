require 'rails_helper'

RSpec.describe 'Feeds page', type: :system do
  describe 'show' do
    let(:empty_label) { 'There are no feeds configured, feel free add some.' }
    it 'shows the right content' do
      visit '/feeds'
      expect(page).to have_content('Feeds configuration')
    end

    it 'shows the empty feeds message' do
      visit '/feeds'
      expect(page).to have_content(empty_label)
    end

    it 'shows the existing feeds' do
      FactoryBot.create_list(:feed, 3)
      Feed.find_each do |feed|
        stub_request(:get, /#{feed.url}/).to_return(status: 200)
      end
      visit '/feeds'
      expect(page).not_to have_content(empty_label)

      Feed.find_each do |feed|
        expect(page).to have_content(feed.title)
        expect(page).to have_content(feed.url)
      end
    end
  end

  describe 'add' do
    it 'creates a new feed' do
      expect(Feed.count).to eq(0)
      visit '/feeds'

      feed_title = Faker::Book.title
      feed_url = Faker::Internet.url
      stub_request(:get, /#{feed_url}/).to_return(status: 200)

      fill_in 'feed_title', with: feed_title
      fill_in 'feed_url', with: feed_url
      click_on 'Add new feed'

      expect(page).to have_content(feed_title)
      expect(page).to have_content(feed_url)
      expect(Feed.count).to eq(1)
    end

    it 'validates the feed attributes' do
      visit '/feeds'

      feed_title = Faker::Book.title

      fill_in 'feed_title', with: feed_title
      fill_in 'feed_url', with: ''

      accept_alert do
        click_on 'Add new feed'
      end
    end
  end

  describe 'update' do
    it 'edits an existing feed' do
      FactoryBot.create_list(:feed, 3)
      Feed.find_each do |feed|
        stub_request(:get, /#{feed.url}/).to_return(status: 200)
      end
      feed = Feed.first

      visit '/feeds'

      feed_title = Faker::Book.title
      feed_url = Faker::Internet.url

      find("#edit_button_#{feed.id}").click
      fill_in "feed_title_#{feed.id}", with: feed_title
      fill_in "feed_url_#{feed.id}", with: feed_url
      find("#save_button_#{feed.id}").click

      wait_for_ajax
      feed.reload
      expect(feed.title).to eq(feed_title)
      expect(feed.url).to eq(feed_url)
    end

    it 'validates the feed attributes' do
      FactoryBot.create_list(:feed, 3)
      Feed.find_each do |feed|
        stub_request(:get, /#{feed.url}/).to_return(status: 200)
      end
      feed = Feed.first

      visit '/feeds'

      feed_title = Faker::Book.title

      find("#edit_button_#{feed.id}").click
      fill_in "feed_title_#{feed.id}", with: feed_title
      fill_in "feed_url_#{feed.id}", with: ''
      accept_alert do
        find("#save_button_#{feed.id}").click
        wait_for_ajax
        feed.reload
        expect(feed.title).not_to eq(feed_title)
      end
    end
  end

  describe 'remove' do
    it 'deletes the first feed' do
      FactoryBot.create_list(:feed, 3)
      Feed.find_each do |feed|
        stub_request(:get, /#{feed.url}/).to_return(status: 200)
      end
      feed = Feed.first

      visit '/feeds'
      find("#remove_button_#{feed.id}").click

      expect(page).not_to have_content(feed.title)
      expect(page).not_to have_content(feed.title)
      expect(Feed.count).to eq(2)
    end
  end
end
