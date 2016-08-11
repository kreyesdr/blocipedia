require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  describe 'getting Welcome#index page' do
    it 'return success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
