require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET app" do
    it 'renders the main page when accessing the root path' do
      get :app
      expect(response).to render_template(:app)
      expect(response).to have_http_status(:ok)
    end
  end
end
