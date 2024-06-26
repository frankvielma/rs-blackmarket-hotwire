# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController do
  describe 'GET #index' do
    context 'when user is authenticated' do
      let(:user) { create(:user, password: 'password', password_confirmation: 'password') }
      let(:product) { create(:product) }

      it 'renders the index template' do
        sign_in user
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the login page' do
        get :index

        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:found)
      end
    end
  end
end
