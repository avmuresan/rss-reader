require 'rails_helper'

RSpec.describe 'App', type: :system do
  describe 'index page' do
    it 'shows the right content' do
      visit root_path
      expect(page).to have_content('Hello Vue!')
    end
  end
end
