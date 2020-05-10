require 'rails_helper'

RSpec.describe 'App', type: :system do
  describe 'home page' do
    it 'shows the right content' do
      visit root_path
      expect(page).to have_content('Latest articles')
    end

    it 'shows the right content when using an invalid path' do
      visit '/invalid'
      expect(page).to have_content('Latest articles')
    end
  end

  describe 'feeds page' do
    it 'shows the right content' do
      visit '/feeds'
      expect(page).to have_content('Feeds configuration')
    end
  end
end
