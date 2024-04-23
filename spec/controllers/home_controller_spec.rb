# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController do
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
  end
end
